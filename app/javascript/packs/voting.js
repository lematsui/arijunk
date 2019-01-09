const upvote = document.querySelector(".epic-win")
const downvote = document.querySelector(".epic-fail")

upvote.addEventListener("click", (event) => {
	const memeId = document.querySelector(".meme-title").id
	mydata = `meme[id]=${memeId}`
  Rails.ajax({
    type: "POST",
    url: "/upvote",
    data: mydata
  });
});

downvote.addEventListener("click", (event) => {
	const memeId = document.querySelector(".meme-title").id
	mydata = `meme[id]=${memeId}`
  Rails.ajax({
    type: "POST",
    url: "/downvote",
    data: mydata
  });
});

