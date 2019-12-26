# ----------------------------------------------------------------------------  IMPORT ------------------------------------ +
from flask import Flask, redirect, url_for,render_template,request,session, flash
from datetime import timedelta


# ----------------------------------------------------------------------------  CONFIG APP -------------------------------- +

app = Flask(__name__)
app.secret_key = "hello"
app.permanent_session_lifetime = timedelta(minutes=5)

# ----------------------------------------------------------------------------  ROUTE APP --------------------------------- +





@app.route("/")
def construct():
    return render_template("errors/under-construct.html")


@app.route("/wellcome/")
def wellcome():
    return render_template("public/wellcome.html")

@app.route("/SignIn/")
def SignIn():
    return render_template("public/wellcome.html")

@app.route("/Register/")
def Register():
    return render_template("public/wellcome.html")





# ----------------------------------------------------------------------------  ERROR HTTP --------------------------------- +

@app.errorhandler(404)
def page_not_found(e):
    return render_template('errors/404.html'), 404

# ----------------------------------------------------------------------------  LAUNCH APP --------------------------------- +

if __name__ == "__main__" :
    app.run(debug=True)




