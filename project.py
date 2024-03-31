from flask import(Flask, render_template,
request, redirect, url_for, flash, session)
from bcrypt import hashpw, gensalt,checkpw
from flask_mysqldb import MySQL
from datetime import datetime
import pandas as pd 
import os


app = Flask(__name__)
app.secret_key = 'cuberskapasar'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'cubersdaw'

mysql = MySQL(app)

@app.route('/',  methods=['GET', 'POST'])
def index():

    return render_template('index.html')

@app.route('/student', methods=['GET', 'POST'])
def student():

    return render_template('student.html')

@app.route('/admin-register', methods=['GET', 'POST'])
def adminreg():
    if request.method == 'POST':
        TEACHER_ID = request.form['TEACHER_ID']  
        NAME = request.form['NAME']
        UI_MAIL = request.form['UIMAIL']
        PASSWORD = request.form['PASSWORD']

        hashpass = hashpw(PASSWORD.encode('utf-8'), gensalt())

        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
        obtain_teacherid = cur.fetchone()
        
        if obtain_teacherid:
            flash('Teacher ID already exists.')
        else:
            cur.execute("INSERT INTO teachers (TEACHER_ID, NAME, UI_MAIL, PASSWORD) VALUES (%s, %s, %s, %s)", 
                        (TEACHER_ID, NAME, UI_MAIL, hashpass))
            mysql.connection.commit()

            flash('Registered successful!')
            return redirect(url_for('adminreg'))

        cur.close()
    return render_template('adminreg.html')

@app.route('/admin-login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        TEACHER_ID = request.form['TEACHER_ID']
        PASSWORD = request.form['PASSWORD']

        cur = mysql.connection.cursor()
        cur.execute("SELECT PASSWORD FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
        check = cur.fetchone()
        if check:
            hashpass = check[0]
            if checkpw(PASSWORD.encode('utf-8'), hashpass.encode('utf-8')):
                session['TEACHER_ID'] = TEACHER_ID
                return redirect(url_for('adminpage'))

        flash('Invalid Teacher ID or Password!')
    return render_template('login.html')


@app.route('/adminpage')
def adminpage():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT COUNT(*) FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    number_of_students = cur.fetchone()

    cur.execute("SELECT NAME FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2 AND TEACHER_ID = %s", (TEACHER_ID,))
    lifeline5 = cur.fetchone()

    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND TEACHER_ID < 3 AND TEACHER_ID = %s", (TEACHER_ID,))
    lifeline3 = cur.fetchone()

    cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >=3 AND TEACHER_ID = %s", (TEACHER_ID,))
    lifeline0 = cur.fetchone()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('adminpage.html',
     TEACHER_ID=session['TEACHER_ID'],
     number_of_students=number_of_students,
     name=name,
     lifeline5=lifeline5,
     lifeline3=lifeline3,
     lifeline0=lifeline0,
     ay=ay)


UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def getname(teacher_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT NAME FROM teachers WHERE TEACHER_ID = %s", (teacher_id,))
    faculty_name = cur.fetchone()
    cur.close()
    return faculty_name

@app.route('/upload3-1', methods=['POST'])
def upload3_1():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))
    
    teacher_id = session.get('TEACHER_ID')
    faculty_name = getname(teacher_id)

    uploaded_file = request.files['file']

    if uploaded_file.filename != '':
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], uploaded_file.filename)

        if file_already_uploaded(uploaded_file.filename, teacher_id):
            flash('File already uploaded!', 'error')
            return redirect(url_for("section1"))

        uploaded_file.save(file_path)

        parseCSV3_1(file_path, teacher_id, faculty_name, uploaded_file.filename)

    return redirect(url_for("section1"))


def file_already_uploaded(filename, teacher_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM citestudents WHERE filename = %s AND TEACHER_ID = %s", (filename, teacher_id))
    result = cur.fetchone()
    cur.close()
    return result



def parseCSV3_1(filePath, teacher_id, faculty_name, filename):
    col_names = ['ID', 'NAME', 'STUDENT_ID', 'SUBJECT',
    'P1', 'P2', 'P3', 'FINAL_GRADE', 'NUMERIC_GRADE', 'REMARKS','ACADEMIC_YEAR']
    csvData = pd.read_csv(filePath, names=col_names, header=None)

    for i, row in csvData.iterrows():
        sql = "INSERT INTO citestudents(ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, REMARKS, ACADEMIC_YEAR, TEACHER_ID, FACULTY_NAME, filename) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (row['ID'], row['NAME'], row['STUDENT_ID'], 
        row['SUBJECT'], row['P1'], row['P2'], row['P3'], 
        row['FINAL_GRADE'], row['NUMERIC_GRADE'], row['REMARKS'],row['ACADEMIC_YEAR'],
        teacher_id, faculty_name, filename)

        cur = mysql.connection.cursor()
        cur.execute(sql, values)
        mysql.connection.commit()
        
        cur.close()


@app.route('/bsit3-1')
def section1():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT name FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, REMARKS, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE TEACHER_ID = %s",
    (TEACHER_ID,))
    student_data = cur.fetchall()

    cur.execute("SELECT COUNT(DISTINCT filename) FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    filecount = cur.fetchone()[0]

    cur.execute("SELECT DISTINCT filename FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    filename = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('bsit3-1.html', 
        TEACHER_ID=session['TEACHER_ID'], 
        name=name,
        student_data=student_data,
        filecount=filecount,
        filename=filename,
        ay=ay)


@app.route('/clear_filename', methods=['POST'])
def clear_filename():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    if request.method == 'POST':
        filename = request.form['filename'] 
        TEACHER_ID = session['TEACHER_ID'] 

        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM citestudents WHERE filename = %s AND TEACHER_ID = %s", (filename, TEACHER_ID))
        mysql.connection.commit()
        cur.close()

    return redirect(url_for('section1'))


@app.route('/lifeline5')
def life5():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT name FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE,ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE < 2 AND TEACHER_ID = %s",
    (TEACHER_ID,))
    student_data = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('life5.html',
        name=name,
        student_data=student_data,
        ay=ay)


@app.route('/lifeline3')
def life3():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']
    
    cur = mysql.connection.cursor()

    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3 AND TEACHER_ID = %s",
    (TEACHER_ID,))
    student_data = cur.fetchall()


    cur.execute("SELECT name FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('life3.html',
        name=name,
        student_data=student_data,
        ay=ay)


@app.route('/lifeline0')
def life0():
    if 'TEACHER_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']
    
    cur = mysql.connection.cursor()

    cur.execute(
    "SELECT NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACADEMIC_YEAR "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 3 AND TEACHER_ID = %s",
    (TEACHER_ID,))
    student_data = cur.fetchall()

    cur.execute("SELECT NAME FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('life0.html',
        name=name,
        student_data=student_data,
        ay=ay)


@app.route('/takeaction', methods=['GET', 'POST'])
def takeaction():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    if request.method == 'POST':
        STUDENT_NAME = request.form['STUDENT_NAME']
        ACADEMIC_YEAR = request.form['ACADEMIC_YEAR']
        ACTION_REMARKS = request.form['ACTION']

        cur = mysql.connection.cursor()

        cur.execute("UPDATE citestudents SET ACTION_REMARKS = %s WHERE NAME = %s AND TEACHER_ID = %s AND ACADEMIC_YEAR = %s",
                    (ACTION_REMARKS, STUDENT_NAME, TEACHER_ID, ACADEMIC_YEAR))
        
        mysql.connection.commit()
        cur.close()

        flash('Action updated successfully')
        return redirect(url_for('takeaction'))

    cur = mysql.connection.cursor()
    cur.execute("SELECT NAME FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT NAME, ACADEMIC_YEAR FROM citestudents WHERE NUMERIC_GRADE >= 3 AND TEACHER_ID = %s", (TEACHER_ID,))
    student = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('takeaction.html',
        name=name,
        student=student,
        ay=ay)


@app.route('/get_current_action', methods=['GET'])
def get_current_action():
    selected_student = request.args.get('student')
    TEACHER_ID = session['TEACHER_ID']
    ACADEMIC_YEAR = request.args.get('academic_year')

    cur = mysql.connection.cursor()
    cur.execute("SELECT ACTION_REMARKS FROM citestudents WHERE NAME = %s AND TEACHER_ID = %s AND ACADEMIC_YEAR = %s",
                (selected_student, TEACHER_ID, ACADEMIC_YEAR))
    current_action = cur.fetchone()
    cur.close()

    if current_action:
        return "ACTION: "+current_action[0]
    else:
        return "NO ACTION YET"


@app.route('/feedback')
def feedbackpage():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()
    cur.execute("SELECT name FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT FEEDBACKS, TIME_SENT FROM feedback WHERE NAME = %s", (name,))
    feedback_data = cur.fetchall()

    cur.execute("SELECT COUNT(FEEDBACKS) FROM feedback WHERE NAME = %s", (name,))
    feednum = cur.fetchone()
    cur.close()

    return render_template('feedback.html',
        name=name,
        feedback_data=feedback_data,
        feednum=feednum)


@app.route('/student-info')
def studentinfo():

    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()
    cur.execute("SELECT name FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute("SELECT * FROM students")
    studinfo = cur.fetchall()

    cur.close()
    return render_template('studentinfo.html',
        name=name,
        studinfo=studinfo)


@app.route('/student-remarks')
def studentremarks():
    if 'TEACHER_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    TEACHER_ID = session['TEACHER_ID']

    cur = mysql.connection.cursor()
    cur.execute("SELECT name FROM teachers WHERE TEACHER_ID = %s", (TEACHER_ID,))
    name = cur.fetchone()

    cur.execute(
    "SELECT NAME, STUDENT_ID, SUBJECT, ACADEMIC_YEAR,ACTION_REMARKS "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 3 AND TEACHER_ID = %s",
    (TEACHER_ID,))
    student_data = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents WHERE TEACHER_ID = %s", (TEACHER_ID,))
    ay = cur.fetchall()

    cur.close()

    return render_template('studentremarks.html',
        name=name,
        student_data=student_data,
        ay=ay)



@app.route('/logout', methods=['POST'])
def logout():
    session.pop('username', None)
    flash('Logged out successfully', 'success')
    return redirect(url_for('login'))




#*** STUDENT ***
@app.route('/student-register', methods=['GET', 'POST'])
def studentreg():
    if request.method == 'POST':
        STUDENT_ID = request.form['STUDENT_ID']
        STUDENT_MAIL = request.form['STUDENT_MAIL']
        FULL_NAME = request.form['FULL_NAME']
        PHONE_NUMBER = request.form['PHONE_NUMBER']
        PASSWORD = request.form['PASSWORD']
        
        hashed_password = hashpw(PASSWORD.encode('utf-8'), gensalt())

        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
        obtain_studentid = cur.fetchone()
        
        if obtain_studentid:
            flash('Student ID already exists.')
        else:
            cur.execute("INSERT INTO students (STUDENT_ID, STUDENT_MAIL, FULL_NAME, PHONE_NUMBER, PASSWORD) VALUES (%s, %s, %s, %s, %s)", 
                        (STUDENT_ID, STUDENT_MAIL, FULL_NAME, PHONE_NUMBER, hashed_password))
            mysql.connection.commit()

            flash('Registered successfully!')
            return redirect(url_for('studentlog'))

        cur.close()
    return render_template('studentreg.html')


@app.route('/student-login', methods=['GET', 'POST'])
def studentlog():
    if request.method == 'POST':
        STUDENT_ID = request.form['STUDENT_ID']
        PASSWORD = request.form['PASSWORD']

        cur = mysql.connection.cursor()
        cur.execute("SELECT PASSWORD FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
        check = cur.fetchone()
        if check:
            hashed_password = check[0]
            if checkpw(PASSWORD.encode('utf-8'), hashed_password.encode('utf-8')):
                session['STUDENT_ID'] = STUDENT_ID
                return redirect(url_for('studentprofile'))

        flash('Invalid Student ID or Password!')
    return render_template('studentlog.html')



@app.route('/student-page')
def studentpage():
    if 'STUDENT_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('studentlog'))

    STUDENT_ID = session['STUDENT_ID']

    cur = mysql.connection.cursor()
    cur.execute("SELECT FULL_NAME FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fn = cur.fetchone()

    cur.execute("SELECT SUBJECT, FACULTY_NAME, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACADEMIC_YEAR FROM citestudents WHERE STUDENT_ID = %s", (STUDENT_ID,))
    student_data = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents")
    ay = cur.fetchall()

    cur.close()

    return render_template('studpage.html',
        fn=fn,
        student_data=student_data,
        ay=ay)

@app.route('/student-feedback', methods=['GET', 'POST'])
def studentfeedback():
    STUDENT_ID = session.get('STUDENT_ID')

    if not STUDENT_ID:

        return redirect(url_for('studentlog'))

    student_id = session['STUDENT_ID']

    if request.method == 'POST':
        if 'TEACHER_ID' not in request.form:
            flash('Please select a teacher')
            return redirect(url_for('studentfeedback'))


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
        cur.execute("SELECT NAME FROM teachers")
        teacher_exists = cur.fetchall()

        if teacher_exists:
            timesent = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            cur.execute("INSERT INTO feedback (NAME, q1, q2, q3, q4, q5, q6, total_rating, FEEDBACKS, TIME_SENT) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    (teacher_id, q1rate, q2rate, q3rate, q4rate, q5rate, q6rate, total_rating, comment, timesent))

            mysql.connection.commit()
            cur.close()
            flash('Feedback Sent!')

    cur = mysql.connection.cursor()

    cur.execute("SELECT FULL_NAME FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fn = cur.fetchone()

    cur.execute("SELECT NAME FROM teachers")
    teachers = cur.fetchall()

    cur.close()

    
    return render_template('studentfeedback.html',
        fn=fn,
        teachers=teachers)


@app.route('/student-profile', methods=['GET','POST'])
def studentprofile():
    if 'STUDENT_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('studentlog'))

    STUDENT_ID = session['STUDENT_ID']

    if request.method == 'POST':
        cur = mysql.connection.cursor()

        PERSONAL_MAIL = request.form['PERSONAL_MAIL']
        PHONE_NUMBER = request.form['PHONE_NUMBER']
        FB_LINK = request.form['FB_LINK']
        STREET = request.form['STREET']
        CITY = request.form['CITY']
        MUNICIPALITY = request.form['MUNICIPALITY']
        ZIP_CODE = request.form['ZIP_CODE']

        if PERSONAL_MAIL:
            cur.execute("UPDATE students SET PERSONAL_MAIL = %s WHERE STUDENT_ID = %s", (PERSONAL_MAIL, STUDENT_ID))
        if PHONE_NUMBER:
            cur.execute("UPDATE students SET PHONE_NUMBER = %s WHERE STUDENT_ID = %s", (PHONE_NUMBER, STUDENT_ID))
        if FB_LINK:
            cur.execute("UPDATE students SET FB_LINK = %s WHERE STUDENT_ID = %s", (FB_LINK, STUDENT_ID))
        if STREET:
            cur.execute("UPDATE students SET STREET = %s WHERE STUDENT_ID = %s", (STREET, STUDENT_ID))
        if CITY:
            cur.execute("UPDATE students SET CITY = %s WHERE STUDENT_ID = %s", (CITY, STUDENT_ID))
        if MUNICIPALITY:
            cur.execute("UPDATE students SET MUNICIPALITY = %s WHERE STUDENT_ID = %s", (MUNICIPALITY, STUDENT_ID))
        if ZIP_CODE:
            cur.execute("UPDATE students SET ZIP_CODE = %s WHERE STUDENT_ID = %s", (ZIP_CODE, STUDENT_ID))

        flash('Updated Successful!')

        mysql.connection.commit()
        cur.close()

    cur = mysql.connection.cursor()

    cur.execute("SELECT PERSONAL_MAIL FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    pm = cur.fetchone()

    cur.execute("SELECT PHONE_NUMBER FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    pn = cur.fetchone()

    cur.execute("SELECT FB_LINK FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fb = cur.fetchone()

    cur.execute("SELECT STREET FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    st = cur.fetchone()

    cur.execute("SELECT CITY FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    ct = cur.fetchone()

    cur.execute("SELECT MUNICIPALITY FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    mc = cur.fetchone()

    cur.execute("SELECT ZIP_CODE FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    zc = cur.fetchone()

    cur.execute("SELECT FULL_NAME FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    fn = cur.fetchone()

    cur.execute("SELECT STUDENT_MAIL FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    sm = cur.fetchone()

    cur.execute("SELECT STUDENT_ID FROM students WHERE STUDENT_ID = %s", (STUDENT_ID,))
    sid = cur.fetchone()

    cur.close()

    return render_template('profile.html',
        fn=fn,
        sid=sid,
        sm=sm,
        pm=pm,
        pn=pn,
        fb=fb,
        st=st,
        ct=ct,
        mc=mc,
        zc=zc)

    
@app.route('/studlogout', methods=['POST'])
def studlogout():
    session.pop('username', None)
    return redirect(url_for('studentlog'))




#*****DEAN******
@app.route('/dean-login', methods=['GET', 'POST'])
def deanlogin():
    if request.method == 'POST':
        DEAN_ID = request.form['DEAN_ID']
        PASSWORD = request.form['PASSWORD']

        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM dean WHERE DEAN_ID = %s AND PASSWORD = %s", (DEAN_ID, PASSWORD))
        user = cur.fetchone()
        cur.close()
        if user:
            session['DEAN_ID'] = DEAN_ID  
            return redirect(url_for('deanpage'))
        else:
            flash('Invalid Credentials! Try Again!')

    return render_template('dean-login.html')


@app.route('/dean-page')
def deanpage():
    if 'DEAN_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    DEAN_ID = session['DEAN_ID']
    selected_semester = request.args.get('semester')

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE DEAN_ID = %s", (DEAN_ID,))
    dn = cur.fetchone()

    if selected_semester == "All" or selected_semester is None:
        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2")
        lifeline5 = cur.fetchone()

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3")
        lifeline3 = cur.fetchone()

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 3")
        lifeline0 = cur.fetchone()

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2")
        l5 = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3")
        l3 = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >=3")
        l0 = cur.fetchone()[0]

        cur.execute(" SELECT FILENAME, COUNT(*) AS count FROM citestudents WHERE NUMERIC_GRADE >= 3 GROUP BY FILENAME ORDER BY count DESC LIMIT 5")
        sectionlife0 = cur.fetchall()
    else:

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2 AND ACADEMIC_YEAR = %s", (selected_semester,))
        lifeline5 = cur.fetchone()

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3 AND ACADEMIC_YEAR = %s", (selected_semester,))
        lifeline3 = cur.fetchone()

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 3 AND ACADEMIC_YEAR = %s", (selected_semester,))
        lifeline0 = cur.fetchone()

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE < 2 AND ACADEMIC_YEAR = %s", (selected_semester,))
        l5 = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >= 2 AND NUMERIC_GRADE < 3 AND ACADEMIC_YEAR = %s", (selected_semester,))
        l3 = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM citestudents WHERE NUMERIC_GRADE >=3 AND ACADEMIC_YEAR = %s", (selected_semester,))
        l0 = cur.fetchone()[0]

        cur.execute(" SELECT FILENAME, COUNT(*) AS count FROM citestudents WHERE NUMERIC_GRADE >= 3 AND ACADEMIC_YEAR = %s GROUP BY FILENAME ORDER BY count DESC LIMIT 5", (selected_semester,))
        sectionlife0 = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents")
    ay = cur.fetchall()

    cur.close()

    chartstat = [
        ['CITE', 'LIFELINES'],
        ['Lifeline5', l5],
        ['Lifeline3', l3],  
        ['Lifeline0', l0]   
    ]

    chartstatsss = [['LIFELINE 0', 'by SECTIONS']]
    for filename, count in sectionlife0:
        if filename.endswith('.csv'):
            filename = filename.rsplit('.', 1)[0]
        chartstatsss.append([filename, count])

    return render_template('deanpage.html',
        dn=dn,
        lifeline5=lifeline5,
        lifeline3=lifeline3,
        lifeline0=lifeline0,
        chartstat=chartstat,
        chartstatsss=chartstatsss,
        ay=ay)



@app.route('/dean-lifeline5')
def deanlife5():
    if 'DEAN_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    DEAN_ID = session['DEAN_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE DEAN_ID = %s", (DEAN_ID,))
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
    if 'DEAN_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    DEAN_ID = session['DEAN_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE DEAN_ID = %s", (DEAN_ID,))
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
    if 'DEAN_ID' not in session:
        flash('Please log in first', 'error')
        return redirect(url_for('deanlogin'))

    DEAN_ID = session['DEAN_ID']

    cur = mysql.connection.cursor()

    cur.execute("SELECT NAME FROM dean WHERE DEAN_ID = %s", (DEAN_ID,))
    name = cur.fetchone()


    cur.execute(
    "SELECT ID, NAME, STUDENT_ID, SUBJECT, P1, P2, P3, FINAL_GRADE, NUMERIC_GRADE, ACTION_REMARKS, FACULTY_NAME, ACADEMIC_YEAR "
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



@app.route('/action-taken')
def actiontaken():
    if 'DEAN_ID' not in session:
        flash('Please log in first')
        return redirect(url_for('login'))

    DEAN_ID = session['DEAN_ID']

    cur = mysql.connection.cursor()
    cur.execute("SELECT NAME FROM dean")
    name = cur.fetchone()

    cur.execute(
    "SELECT NAME, STUDENT_ID, SUBJECT, ACTION_REMARKS, ACADEMIC_YEAR, FACULTY_NAME "
    "FROM citestudents "
    "WHERE NUMERIC_GRADE >= 3")
    student_data = cur.fetchall()

    cur.execute("SELECT DISTINCT ACADEMIC_YEAR FROM citestudents")
    ay = cur.fetchall()

    cur.close()

    return render_template('actiontaken.html',
        name=name,
        student_data=student_data,
        ay=ay) 


@app.route('/deanlogout', methods=['POST'])
def deanlogout():
    return redirect(url_for('deanlogin'))


if __name__ == '__main__':
    app.run(debug=True, port=5000)

    