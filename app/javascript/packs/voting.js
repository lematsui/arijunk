let upvote = document.querySelector(".epic-win")
let upvoteDone = document.querySelector(".epic-win-voted")
let downvote = document.querySelector(".epic-fail")
let downvoteDone = document.querySelector(".epic-fail")

function checkForUpvote() {
  let upvote = document.querySelector(".epic-win")
  if (upvote) {
    upvote.addEventListener("click", (event) => {
      console.log("adding upvote")
    	const memeId = document.querySelector(".meme-title").id
    	mydata = `meme[id]=${memeId}`
      Rails.ajax({
        type: "POST",
        url: "/upvote",
        data: mydata
      });
      upvote.classList.remove("epic-win");
      upvote.classList.add("epic-win-voted");
      checkForUpvoteDone();
    });
  };
};

function checkForUpvoteDone() {
  let upvoteDone = document.querySelector(".epic-win-voted")
  if (upvoteDone) {
    upvoteDone.addEventListener("click", (event) => {
      console.log("removing upvote")
      const memeId = document.querySelector(".meme-title").id
      mydata = `meme[id]=${memeId}`
      Rails.ajax({
        type: "POST",
        url: "/remove-upvote",
        data: mydata
      });
      upvoteDone.classList.remove("epic-win-voted");
      upvoteDone.classList.add("epic-win");
      checkForUpvote();
    });
  };
};

if (downvote) {
  downvote.addEventListener("click", (event) => {
  	const memeId = document.querySelector(".meme-title").id
  	mydata = `meme[id]=${memeId}`
    Rails.ajax({
      type: "POST",
      url: "/downvote",
      data: mydata
    });
  });
};

checkForUpvote();
checkForUpvoteDone();



