from flask import Flask, request, render_template
import psycopg2
import os

app = Flask(__name__)

DB_HOST = os.environ.get("DB_HOST")
DB_NAME = os.environ.get("DB_NAME")
DB_USER = os.environ.get("DB_USER")
DB_PASS = os.environ.get("DB_PASS")

def get_db():
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )

@app.route("/health")
def health():
    return "OK", 200


@app.route("/", methods=["GET","POST"])
def index():

    conn = get_db()
    cur = conn.cursor()

    cur.execute("""
    CREATE TABLE IF NOT EXISTS students(
        id SERIAL PRIMARY KEY,
        name TEXT
    )
    """)

    if request.method == "POST":
        student = request.form["name"]
        cur.execute("INSERT INTO students(name) VALUES (%s)", (student,))
        conn.commit()

    cur.execute("SELECT * FROM students")
    students = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("index.html", students=students)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)