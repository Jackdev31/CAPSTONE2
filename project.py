from flask import(Flask,
render_template,request, redirect, url_for, flash, session,jsonify)
from flask_mysqldb import MySQL
from datetime import datetime
import pandas as pd 
import os

app = Flask(__name__)
app.secret_key = 'cuberskapasar'

# para sa connectivity sang database
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'cubersdaw'

mysql = MySQL(app)

@app.route('/',methods=['GET', 'POST'])
def index():

    return render_template('index.html')


@app.route('/admin-login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # validation if chakto ang user sa database admin table
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM admin WHERE username = %s AND password = %s", (username, password))
        user = cur.fetchone()
        cur.close()

        if user:
            session['username'] = username  #para mag store sang username sa session
            return redirect(url_for('adminpage'))  #makadto sa adminpage if correct validation
        else:
            flash('Invalid username or password', 'error')

    return render_template('login.html')

@app.route('/adminpage')
def adminpage():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    # Get the logged-in teacher's ID
    username = session['username']

    cur = mysql.connection.cursor()

    # Count the number of students for the logged-in teacher
    cur.execute("SELECT COUNT(*) FROM citestudents WHERE username = %s", (username,))
    number_of_students = cur.fetchone()

    cur.execute("SELECT NAME FROM admin WHERE username = %s", (username,))
    name = cur.fetchone()

    # Count the number of students with numeric grades greater than 8
    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2 AND username = %s", (username,))
    lifeline5 = cur.fetchone()

    # Count the number of students with numeric grades between 5 and 8
    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND username < 3 AND username = %s", (username,))
    lifeline3 = cur.fetchone()

    # Count the number of students with numeric grades less than 5
    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >=3 AND username = %s", (username,))
    lifeline0 = cur.fetchone()


    cur.close()

    return render_template('adminpage.html',
     username=session['username'],
     number_of_students=number_of_students,
     name=name,
     lifeline5=lifeline5,
     lifeline3=lifeline3,
     lifeline0=lifeline0)


#csv upload folder holder
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/upload3-1', methods=['POST'])
def upload3_1():
    # Check if user is logged in
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    # Access the teacher's ID from the session
    teacher_id = session.get('username')

    uploaded_file = request.files['file']

    if uploaded_file.filename != '':
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], uploaded_file.filename)

        # Check if the file with the same name already exists for the logged-in user
        if file_already_uploaded(uploaded_file.filename, teacher_id):
            flash('File already uploaded!', 'error')
            return redirect(url_for("section1"))

        uploaded_file.save(file_path)

        # Parse CSV data and insert into the database
        parseCSV3_1(file_path, teacher_id, uploaded_file.filename)

    return redirect(url_for("section1"))


def file_already_uploaded(filename, teacher_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM citestudents WHERE filename = %s AND username = %s", (filename, teacher_id))
    result = cur.fetchone()
    cur.close()
    return result



def parseCSV3_1(filePath, teacher_id, filename):
    col_names = ['ID', 'NAME', 'STUDENT_ID', 'SUBJECT',
    'P1', 'P2', 'P3', 'FINAL_GRADE', 'NUMERIC_GRADE', 'REMARKS','ACADEMIC_YEAR']
    csvData = pd.read_csv(filePath, names=col_names, header=None)

    for i, row in csvData.iterrows():
        sql = "INSERT INTO citestudents(ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, REMARKS, ACADEMIC_YEAR, username, filename) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (row['ID'], row['NAME'], row['STUDENT_ID'], 
        row['SUBJECT'], row['P1'], row['P2'], row['P3'], 
        row['FINAL_GRADE'], row['NUMERIC_GRADE'], row['REMARKS'],row['ACADEMIC_YEAR'],
        teacher_id, filename)

        cur = mysql.connection.cursor()
        cur.execute(sql, values)
        mysql.connection.commit()
        
        cur.close()


@app.route('/bsit3-1')
def section1():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    user_id = session['username']

    cur = mysql.connection.cursor()

    cur.execute("SELECT name FROM admin WHERE username = %s", (user_id,))
    name = cur.fetchone()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, REMARKS, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE username = %s",
    (user_id,))
    student_data = cur.fetchall()

    cur.execute("SELECT COUNT(DISTINCT filename) FROM citestudents WHERE username = %s", (user_id,))
    filecount = cur.fetchone()[0]

    cur.execute("SELECT DISTINCT filename FROM citestudents WHERE username = %s", (user_id,))
    filename = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE username = %s", (user_id,))
    ay = cur.fetchall()


    cur.close()

    return render_template('bsit3-1.html', 
        username=session['username'], 
        name=name,
        student_data=student_data,
        filecount=filecount,
        filename=filename,
        ay=ay)

@app.route('/clear_filename', methods=['POST'])
def clear_filename():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    if request.method == 'POST':
        filename = request.form['filename']  # Extract the filename from the form data
        username = session['username']  # Get the logged-in username

        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM citestudents WHERE filename = %s AND username = %s", (filename, username))
        mysql.connection.commit()
        cur.close()

    return redirect(url_for('section1'))


@app.route('/lifeline5')
def life5():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    user_id = session['username']

    cur = mysql.connection.cursor()

    cur.execute("SELECT name FROM admin WHERE username = %s", (user_id,))
    name = cur.fetchone()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE,ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE < 2 AND username = %s",
    (user_id,))
    student_data = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE username = %s", (user_id,))
    ay = cur.fetchall()

    cur.close()

    return render_template('life5.html',
        name=name,
        student_data=student_data,
        ay=ay)

@app.route('/lifeline3')
def life3():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    user_id = session['username']
    
    cur = mysql.connection.cursor()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3 AND username = %s",
    (user_id,))
    student_data = cur.fetchall()


    cur.execute("SELECT name FROM admin WHERE username = %s", (user_id,))
    name = cur.fetchone()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE username = %s", (user_id,))
    ay = cur.fetchall()

    cur.close()

    return render_template('life3.html',
        name=name,
        student_data=student_data,
        ay=ay)

        

@app.route('/lifeline0')
def life0():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    user_id = session['username']
    
    cur = mysql.connection.cursor()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACTION_REMARKS, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 3 AND username = %s",
    (user_id,))
    student_data = cur.fetchall()

    cur.execute("SELECT name FROM admin WHERE username = %s", (user_id,))
    name = cur.fetchone()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE username = %s", (user_id,))
    ay = cur.fetchall()

    cur.close()

    return render_template('life0.html',
        name=name,
        student_data=student_data,
        ay=ay)

@app.route('/update_action_remarks', methods=['POST'])
def update_action_remarks():
    data = request.json
    student_id = data.get('id')
    action_remarks = data.get('action_remarks')

    # Ensure teacher is logged in
    if 'username' not in session:
        return jsonify({'message': 'Unauthorized'})

    teacher_id = session['username']

    cursor = mysql.connection.cursor()

    # Update action remarks only for the logged-in teacher's students
    if action_remarks == "":
        cursor.execute("UPDATE citestudents SET ACTION_REMARKS = NULL WHERE ID = %s AND username = %s", (student_id, teacher_id))
    else:
        cursor.execute("UPDATE citestudents SET ACTION_REMARKS = %s WHERE ID = %s AND username = %s", (action_remarks, student_id, teacher_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify()



@app.route('/feedback')
def feedbackpage():
    if 'username' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    user_id = session['username']

    cur = mysql.connection.cursor()
    cur.execute("SELECT name FROM admin WHERE username = %s", (user_id,))
    name = cur.fetchone()

    # Fetch feedbacks and corresponding times
    cur.execute("SELECT FEEDBACKS, TIME_SENT FROM feedback WHERE NAME = %s", (name,))
    feedback_data = cur.fetchall()

    cur.execute("SELECT COUNT(FEEDBACKS) FROM feedback WHERE NAME = %s", (name,))
    feednum = cur.fetchone()
    cur.close()

    return render_template('feedback.html',
        name=name,
        feedback_data=feedback_data,
        feednum=feednum)

@app.route('/logout', methods=['POST'])
def logout():
    session.pop('username', None)
    flash('Logged out successfully', 'success')
    return redirect(url_for('login'))




#*** STUDENT ***
@app.route('/student-login', methods=['GET', 'POST'])
def studentlog():
    if request.method == 'POST':
        STUDENT_ID = request.form['STUDENT_ID']
        PASSWORD = request.form['PASSWORD']

        
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM students WHERE STUDENT_ID = %s AND PASSWORD = %s", (STUDENT_ID, PASSWORD))
        studentid = cur.fetchone()
        cur.close()

        if studentid:
            session['STUDENT_ID'] = STUDENT_ID  # para ma retrieve kung sin o nga user
            return redirect(url_for('studentpage'))  # sulod sa student page if succesfull

        else:
            flash('Incorrect Credentials. Try again!', 'error') 

    return render_template('studentlog.html')

@app.route('/student-register', methods=['GET','POST'])
def studentreg():
    if request.method == 'POST':
        STUDENT_ID = request.form['STUDENT_ID']  
        FULL_NAME = request.form['FULL_NAME']
        PASSWORD = request.form['PASSWORD']

        
        #validation if ang student id ara na sa table nga students
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
        obtain_studentid = cur.fetchone()
        cur.close()

        if obtain_studentid:
            flash('Student ID already exists.')
        else:
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO students (STUDENT_ID, FULL_NAME, PASSWORD) VALUES (%s, %s, %s)", 
            (STUDENT_ID, FULL_NAME, PASSWORD))
            mysql.connection.commit() #kung wala ga exist ang student it amo ni commit ya
            cur.close()

            flash('Registered successfully!')
            return redirect(url_for('studentlog'))

    return render_template('studentreg.html')


@app.route('/student-page')
def studentpage():
    if 'STUDENT_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('studentlog'))

    # Get the logged-in teacher's ID
    STUDENT_ID = session['STUDENT_ID']

    cur = mysql.connection.cursor()
    cur.execute("SELECT FULL_NAME FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fn = cur.fetchone()

    cur.execute("SELECT SUBJECT FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    subject = cur.fetchall()

    cur.execute("SELECT P1 FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    p1 = cur.fetchall()

    cur.execute("SELECT P2 FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    p2 = cur.fetchall()

    cur.execute("SELECT P3 FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    p3 = cur.fetchall()

    cur.execute("SELECT FINAL_GRADE FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fg = cur.fetchall()

    cur.execute("SELECT NUMERIC_GRADE FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    ng = cur.fetchall()

    cur.execute("SELECT username FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    facn = cur.fetchall()

    cur.close()

    return render_template('studpage.html',
        fn=fn,
        subject=subject,
        p1=p1,
        p2=p2,
        p3=p3,
        fg=fg,
        ng=ng,
        facn=facn)

@app.route('/student-feedback', methods=['GET', 'POST'])
def studentfeedback():
    STUDENT_ID = session.get('STUDENT_ID')

    if not STUDENT_ID:
        # indi ka sulog sa direct kung wala ka login
        return redirect(url_for('studentlog'))

    student_id = session['STUDENT_ID']

    if request.method == 'POST':
        teacher_id = request.form['TEACHER_ID']
        q1rate = request.form['q1rate']
        q2rate = request.form['q2rate']
        q3rate = request.form['q3rate']
        q4rate = request.form['q4rate']
        q5rate = request.form['q5rate']
        q6rate = request.form['q6rate']
        comment = request.form['comment']

        total_rating = sum(int(rate) for rate in [q1rate, q2rate, q3rate, q4rate, q5rate, q6rate])
    
        cur = mysql.connection.cursor()
        cur.execute("SELECT NAME FROM admin")
        teacher_exists = cur.fetchall()

        if teacher_exists:
            timesent = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            cur.execute("INSERT INTO feedback (NAME, q1, q2, q3, q4, q5, q6, total_rating, FEEDBACKS, TIME_SENT) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    (teacher_id, q1rate, q2rate, q3rate, q4rate, q5rate, q6rate, total_rating, comment, timesent))

            mysql.connection.commit()
            cur.close()
            flash('Feedback Sent!')

    # para mag fetch sang data pakadto sa template
    cur = mysql.connection.cursor()

    cur.execute("SELECT FULL_NAME FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fn = cur.fetchone()

    cur.execute("SELECT NAME FROM admin")
    teachers = cur.fetchall()

    cur.close()

    
    return render_template('studentfeedback.html',
        fn=fn,
        teachers=teachers)

@app.route('/student-profile')
def studentprofile():
    if 'STUDENT_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('studentlog'))

    # Get the logged-in teacher's ID
    STUDENT_ID = session['STUDENT_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT FULL_NAME FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fn = cur.fetchone()

    cur.execute("SELECT STUDENT_ID FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    sid = cur.fetchone()

    cur.close()

    return render_template('profile.html',
        fn=fn,
        sid=sid)
    
@app.route('/studlogout', methods=['POST'])
def studlogout():
    session.pop('username', None)
    return redirect(url_for('studentlog'))

@app.route('/dean-login', methods=['GET', 'POST'])
def deanlogin():
    if request.method == 'POST':
        TEACHER_ID = request.form['TEACHER_ID']
        PASSWORD = request.form['PASSWORD']

        # validation if chakto ang user sa database admin table
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM dean WHERE TEACHER_ID = %s AND PASSWORD = %s", (TEACHER_ID, PASSWORD))
        user = cur.fetchone()
        cur.close()

        if user:
            session['TEACHER_ID'] = TEACHER_ID  #para mag store sang username sa session
            return redirect(url_for('deanpage'))  #makadto sa adminpage if correct validation
        else:
            flash('Invalid Credentials! Try Again!', 'error')

    return render_template('dean-login.html')

@app.route('/dean-page')
def deanpage():

    if 'TEACHER_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    TEACHER_ID = session['TEACHER_ID']

    # para mag fetch sang data pakadto sa template
    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE TEACHER_ID = %s", (TEACHER_ID,))
    dn = cur.fetchone()

    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2 ")
    lifeline5 = cur.fetchone()

    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND 3 ")
    lifeline3 = cur.fetchone()


    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >=3 ")
    lifeline0 = cur.fetchone()

    cur.close()

    return render_template('deanpage.html',
        dn=dn,
        lifeline5=lifeline5,
        lifeline3=lifeline3,
        lifeline0=lifeline0)

@app.route('/dean-lifeline5')
def deanlife5():
    if 'TEACHER_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACADEMIC_YEAR "
    "FROM citestudents WHERE NUMERIC_GRADE < 2 ")
    data5 = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents")
    ay = cur.fetchall()

    cur.close()


    return render_template('deanlife5.html',
        name=name,
        data5=data5,
        ay=ay)

@app.route('/dean-lifeline3')
def deanlife3():
    if 'TEACHER_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACADEMIC_YEAR "
                "FROM citestudents WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3")
    data3 = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents")
    ay = cur.fetchall()

    cur.close()

    return render_template('deanlife3.html',
        name=name,
        data3=data3,
        ay=ay)

@app.route('/dean-lifeline0')
def deanlife0():
    if 'TEACHER_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()


    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACTION_REMARKS, username, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 3 ")
    data0 = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents")
    ay = cur.fetchall()

    cur.close()

    return render_template('deanlife0.html',
        name=name,
        data0=data0,
        ay=ay)

@app.route('/deanlogout', methods=['POST'])
def deanlogout():
    return redirect(url_for('deanlogin'))


if __name__ == '__main__':
    app.run(debug=True, port=8080)

    