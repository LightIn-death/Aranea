from flask import Flask, redirect, url_for,render_template,request,session, flash
from datetime import timedelta
from flask_sqlalchemy import  sqlalchemy



app = Flask(__name__)
app.secret_key = "hello"
app.permanent_session_lifetime = timedelta(minutes=5)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.sqlite3'


db = sqlalchemy(app)

class users(db.ModeL):
    _id = db.Column("id",db.Iteger, primary_key=True)
 



@app.route("/")
def home():
    return render_template("index.html",content=["joe","tel","tami","xami","rachelle"])

@app.route("/login/", methods=['GET', 'POST'])
def login():
    if request.method == "POST":
        session.permanent = True
        user = request.form["name"]
        session["user"]=user
        return redirect(url_for("user"))
    else:
        return render_template("login.html")


@app.route("/user", methods=["Post","Get"])
def user():
    email=None
    if "user" in session :
        user = session["user"]
        if request.method == "POST":
            email = request.form["email"]
            session["email"] = email
            
        else :
            if "email" in session:
                email = session["email"] 
                
        print(email)
        return render_template("user.html",email=email)
    else :
        return redirect(url_for("login"))


@app.route("/logout")
def logout():
     if "user" in session :
         session.pop("user",None)
         session.pop("email",None)
         flash("You have been disconnected","info")
     return redirect(url_for("login"))


















if __name__ == "__main__" :
    app.run(debug=True)




