# ----------------------------------------------------------------------------  IMPORT ------------------------------------ +
from flask import Flask, redirect, url_for, render_template, request, session, flash
from flask_sqlalchemy import SQLAlchemy
from datetime import timedelta

# ----------------------------------------------------------------------------  CONFIG APP -------------------------------- +

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:''@localhost/aranea'
app.secret_key = "A!zefé;:é-è_à@"
app.permanent_session_lifetime = timedelta(minutes=5)
db = SQLAlchemy(app)


# ----------------------------------------------------------------------------  CONFIG DB --------------------------------- +

class Users(db.Model):
    __tablename__ = "users"
    id_user = db.Column('id_user', db.INTEGER, primary_key=True)
    username = db.Column('username', db.VARCHAR)
    email = db.Column('email', db.VARCHAR)
    password = db.Column('password', db.VARCHAR)
    description = db.Column('description', db.VARCHAR)
    age = db.Column('age', db.DATE)
    photo = db.Column('photo', db.VARCHAR)
    score = db.Column('score', db.INTEGER)
    mood = db.Column('mood', db.INTEGER)


class Messages(db.Model):
    __tablename__ = "messages"
    id_message = db.Column('id_message', db.INTEGER, primary_key=True)
    send_time = db.Column('send_time', db.DATETIME)
    receive_time = db.Column('receive_time', db.DATETIME)
    content = db.Column('content', db.VARCHAR)
    img_link = db.Column('img_link', db.VARCHAR)

    from_id = db.Column(db.INTEGER, db.ForeignKey('users.id_user'))
    in_relation_id = db.Column(db.INTEGER, db.ForeignKey('relations.id_relation'))


class Relations(db.Model):
    __tablename__ = "relations"
    id_relation = db.Column('id_relation', db.INTEGER, primary_key=True)
    user1_id = db.Column('user1_id', db.INTEGER)
    user2_id = db.Column('user2_id', db.INTEGER)
    relation_score = db.Column('relation_score', db.INTEGER)

    messages = db.relationship('Messages', backref='convs')


# ----------------------------------------------------------------------------  ROUTE APP --------------------------------- +


@app.route("/")
@app.route("/wellcome/")
def wellcome():
    return render_template("public/wellcome.html")


@app.route("/SignIn/")
def SignIn():
    return render_template("public/signIn.html")


@app.route("/register/")
def Register():
    return render_template("public/register.html")


# ----------------------------------------------------------------------------  ERROR HTTP --------------------------------- +

@app.errorhandler(404)
def page_not_found(e):
    return render_template("errors/under-construct.html")
    # return render_template('errors/404.html'), 404


# ----------------------------------------------------------------------------  LAUNCH APP --------------------------------- +

if __name__ == "__main__":
    app.run(debug=True)
