from __init__ import Relations
import random


def newRelByClosestUser(listRep, myscore, my_id, listUser):
    val = 100
    user = random.choice(listUser).id_user
    for i in listRep:
        dist = abs(float(myscore) - float(i.reponse1))
        if dist < val:
            val = dist
            user = i.user_id
    relation = Relations(
        user1_id=my_id,
        user2_id=user)
    return relation


def newFormNeverSeen(listForms, listReps):
    listFormsFinal = []
    for li in listForms:
        tokeep = True
        for re in listReps:
            if re.form_id == li.id_form:
                tokeep = False
        if tokeep:
            listFormsFinal.append(li)

    print(f"\n\n {listFormsFinal} {len(listFormsFinal)}  \n\n")
    if len(listFormsFinal) <= 0 :
        return None
    else:
        return listFormsFinal[-1]
