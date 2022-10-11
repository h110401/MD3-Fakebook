let disablePostButton = () => {
    let content = document.querySelector("textarea").value;
    let button = document.querySelector(".modal-footer > button");
    button.disabled = content.trim() === "" && file == null;
    console.log(content.trim() === "" && file == null)
}

function expandTextarea(id) {
    document.getElementById(id).addEventListener('input', function () {
        this.style.overflow = 'hidden';
        this.style.height = 0;
        this.style.height = this.scrollHeight + 'px';
    }, false);
}

expandTextarea('content-box');

let displayPhotoAdd = () => {
    let displayPhoto = document.querySelector("#add-photo-div");
    displayPhoto.style.display = "block";
}

let hidePhotoAdd = () => {
    let displayPhoto = document.querySelector("#add-photo-div");
    displayPhoto.style.display = "none";
    let img = document.querySelector("#imgDiv img");
    if (img != null) {
        img.remove();
        document.querySelector(".fileButtonBg > span").style.display = "inline";
        document.getElementById("fileButtonLabel").style.width = "100%";
        document.getElementById("fileButtonLabel").style.height = "200px";
        document.getElementById("fileButtonLabel").style.paddingBottom = "0";
        let divLocation = document.getElementById("imgDiv");
        divLocation.style.display = "none";
        let fileBtn = document.getElementById("fileButton");
        fileBtn.disabled = false;
        fileBtn.value = "";
        file = null;
        let button = document.querySelector(".modal-footer > button");
        button.disabled = true;
    }
}

let createPostModal = document.querySelector("#create-post-modal");
createPostModal.addEventListener("click", (e) => {
    if (!document.querySelector(".modal-content").contains(e.target)) {
        let displayPhoto = document.querySelector("#add-photo-div");
        displayPhoto.style.display = "none";
        let img = document.querySelector("#imgDiv img");
        if (img != null) {
            img.remove();
            document.querySelector(".fileButtonBg > span").style.display = "inline";
            document.getElementById("fileButtonLabel").style.width = "100%";
            document.getElementById("fileButtonLabel").style.height = "200px";
            document.getElementById("fileButtonLabel").style.paddingBottom = "0";
            let divLocation = document.getElementById("imgDiv");
            divLocation.style.display = "none";
            let fileBtn = document.getElementById("fileButton");
            fileBtn.disabled = false;
            fileBtn.value = "";
            file = null;
            let button = document.querySelector(".modal-footer > button");
            button.disabled = true;
        }
    }

})

let deletePost = (id) => {
    document.getElementById(id).submit();
}

let displayCommentArea = (id) => {
    document.getElementById('comment-area-' + id).style.display = "block";
}

let addPhoto = (e) => {
    e.preventDefault();
    e.stopPropagation();

    if (e.dataTransfer.files.length > 0) {

        let fileImg = e.dataTransfer.files[0];

        let divLocation = document.getElementById("imgDiv");
        divLocation.style.display = "block";
        document.querySelector(".fileButtonBg > span").style.display = "none";

        let output = document.createElement("img");

        output.src = URL.createObjectURL(fileImg);
        output.onload = function () {
            URL.revokeObjectURL(output.src) // free memory
        }

        output.style.width = "100%";
        output.style.borderRadius = '8px';
        document.getElementById("fileButtonLabel").style.width = "100%";
        document.getElementById("fileButtonLabel").style.height = "100%";
        document.getElementById("fileButtonLabel").style.paddingBottom = "8px";
        document.getElementById("fileButton").disabled = true;

        divLocation.append(output);
        let button = document.querySelector(".modal-footer > button");
        button.disabled = false;
    }

}
document.getElementById('fileButtonLabel').addEventListener('drop', addPhoto)
document.getElementById('fileButtonLabel').addEventListener('dragover', addPhoto)


let pre = true;
let noticeDiv = document.getElementById("notice-div");
let displayNotification = () => {
    noticeDiv.style.display = noticeDiv.style.display === "none" ? "block" : "none";
    pre = false;
}
addEventListener("click", e => {
    if (noticeDiv.style.display === "block") {
        if (e.target !== noticeDiv && pre && !noticeDiv.contains(e.target)) {
            noticeDiv.style.display = "none";
        }
        pre = true;
    }
})