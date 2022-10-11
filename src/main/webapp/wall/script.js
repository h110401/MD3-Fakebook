let displayNameInput = () => {
    document.getElementById("change-name").style.display = "block";
}

let hideNameInput = () => {
    document.getElementById("change-name").style.display = "none";
}

let displayAvatarInput = () => {
    document.getElementById("change-avatar").style.display = "block";
}

let hideAvatarInput = () => {
    document.getElementById("change-avatar").style.display = "none";
    if (temp !== null) {
        document.getElementById("avatar").src = temp;
        temp = null;
    }
}

let displayPassInput = () => {
    document.getElementById("change-pass").style.display = "block";
}

let hidePassInput = () => {
    document.getElementById("change-pass").style.display = "none";
}

let checkRepeatPass = () => {
    let pass = document.getElementById("pass").value;
    let repeat = document.getElementById("repeat").value;

    if (pass.trim().length === 0 || repeat.trim().length === 0) {
        alert("Cannot input blank!");
    } else if (pass === repeat) {
        document.getElementById("change-pass").submit();
    } else {
        alert("Repeat password not match!");
    }
}