from flask import Flask, redirect, url_for,render_template,request,session, flash
from datetime import timedelta
from flask_sqlalchemy import  SQLAlchemy



app = Flask(__name__)
app.secret_key = "hello"
app.permanent_session_lifetime = timedelta(minutes=5)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.sqlite3'


db = SQLAlchemy(app)

class users(db.Model):
    _id = db.Column("id",db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100))

    def __init__(self, name, email):
        self.name = name
        self.email = email
 



@app.route("/")
def home():
    return render_template("index.html",content=["joe","tel","tami","xami","rachelle"])

@app.route("/login/", methods=['GET', 'POST'])
def login():
    if request.method == "POST":
        session.permanent = True
        user = request.form["name"]
        session["user"]=user

        found_user = users.query.filter_by(name=user).first()
        if found_user :
            session["email"] = found_user.email
        else:
            usr = users(user, "")
            db.session.add(usr)
            db.session.commit()

        flash("Login Succesful ! ")
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
            found_user = users.query.filter_by(name=user).first()
            found_user.email = email
            db.session.commit()

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
    db.create_all()
    app.run(debug=True)




