# ----------------------------------------------------------------------------  IMPORT ------------------------------------ +
from flask import Flask, redirect, url_for, render_template, request, session, flash
from flask_sqlalchemy import SQLAlchemy
from datetime import timedelta, datetime

# ----------------------------------------------------------------------------  CONFIG APP -------------------------------- +

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:''@localhost/aranea'
app.secret_key = "A!zefé;:é-è_à@"
app.permanent_session_lifetime = timedelta(days=7)
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
    score = db.Column('score', db.INTEGER, default=0)
    mood = db.Column('mood', db.INTEGER, default=0)


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
def Wellcome():
    if session.get('auth') == None:
        return render_template("public/wellcome.html")
    else:
        return redirect(url_for('home'))


@app.route("/home/")
def home():
    if session.get('auth') == None:
        return redirect(url_for('Wellcome'))
    else:
        return render_template("private/home.html")


@app.route("/conv/")
def conv():
    if session.get('auth') == None:
        return redirect(url_for('Wellcome'))
    else:
        id = session["id"]
        RelationList = Relations.query.filter((Relations.user1_id == id) | (Relations.user2_id == id)).all()
        UserList = []
        for conv in RelationList:
            if conv.user1_id != id:
                usr = conv.user1_id
            if conv.user2_id != id:
                usr = conv.user2_id
            UserList.append(Users.query.filter_by(id_user=usr).first())

        return render_template("private/convs.html", RelationList=RelationList, id=id, UserList=UserList)


@app.route("/message/", methods=["GET", "POST"])
def message():
    if session.get('auth') == None:
        return redirect(url_for('Wellcome'))
    else:
        if request.method == "POST":
            if request.form['btn'] == "send":
                _content = request.form['text']
                if _content != "":
                    newMessage = Messages(
                        content=_content,
                        from_id=session['id'],
                        in_relation_id=session["rel_id"],
                        send_time=datetime.now()
                    )
                    db.session.add(newMessage)
                    db.session.commit()
            else:
                session["rel_id"] = request.form['rel_id']
            rel_id = session["rel_id"]
        messages = Messages.query.filter_by(in_relation_id=rel_id).all()
        return render_template("private/message.html", messages=messages, id=session['id'])


@app.route("/logout/")
def logout():
    session.pop("auth")
    return redirect(url_for('Wellcome'))


@app.route("/SignIn/", methods=["GET", "POST"])
def SignIn():
    if request.method != "POST":
        return render_template("public/signIn.html")
    else:

        _email = request.form['email']
        _password = request.form['password']
        user = Users.query.filter_by(email=_email, password=_password).first()
        if user:
            session["auth"] = True
            session["id"] = user.id_user
            session["email"] = user.email
            session["username"] = user.username
            session["description"] = user.description
            session["age"] = user.age
            session["photo"] = user.photo
            session["score"] = user.score
            session["mood"] = user.mood
            # f'{session["email"]} {session["username"]} {session["description"]} {session["age"]} {session["photo"]} {session["score"]} {session["mood"]}'
            return redirect(url_for('home'))
        else:
            return render_template("public/signIn.html")


@app.route("/register/", methods=["GET", "POST"])
def Register():
    if request.method != "POST":
        return render_template("public/register.html")
    else:
        _username = request.form['username']
        _email = request.form['email']
        _password = request.form['password']
        _password_check = request.form['password-check']
        if _password == _password_check:
            newUser = Users(
                username=_username,
                email=_email,
                password=_password
            )
            db.session.add(newUser)
            db.session.commit()
            return redirect(url_for('SignIn'))
        else:
            return render_template("public/register.html")


# ----------------------------------------------------------------------------  ERROR HTTP --------------------------------- +

@app.errorhandler(404)
def page_not_found(e):
    return render_template("errors/under-construct.html")
    # return render_template('errors/404.html'), 404


# ----------------------------------------------------------------------------  LAUNCH APP --------------------------------- +

if __name__ == "__main__":
    app.run(debug=True)
