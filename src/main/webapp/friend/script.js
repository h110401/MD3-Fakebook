let requestDiv = document.getElementById("request-div");
let friendDiv = document.getElementById("friend-div");
let requestBtn = document.getElementById("request-btn");
let listBtn = document.getElementById("list-btn");

let toggle = (element) => {
    let check = element === "request";

    if (check) {
        requestDiv.style.display = "block";
        requestBtn.style.background = "#e6e6e6";
        friendDiv.style.display = "none";
        listBtn.style.background = "";
    } else {
        requestDiv.style.display = "none";
        requestBtn.style.background = "";
        friendDiv.style.display = "block";
        listBtn.style.background = "#e6e6e6";
    }
}

let img1 = document.querySelectorAll(".list-request-image");

let resizeImg = () => {
    img1.forEach(i => {
        i.height = i.width;
    })

}

let resize = () => {
    resizeImg();
}
resizeImg();
window.addEventListener("resize", resize);
