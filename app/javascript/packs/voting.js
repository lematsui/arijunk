const upvote = document.querySelector(".upvote");
const downvote = document.querySelector(".downvote");
const voteNumber = document.getElementById("vote-number");
const meme = document.querySelector(".meme-title");

if (upvote) {
  upvote.addEventListener("click", (event) => {
    if (upvote.classList.contains("epic-win")) {
      let memeId = meme.id;
      console.log("adding upvote");
    	mydata = `meme[id]=${memeId}`
      Rails.ajax({
        type: "POST",
        url: "/upvote",
        data: mydata
      });
      upvote.classList.remove("epic-win");
      upvote.classList.add("epic-win-voted");
      oneVoteAllowed();
      addOne();
    } else if (upvote.classList.contains("epic-win-voted")) {
      const memeId = meme.id;
      console.log("removing upvote");
      mydata = `meme[id]=${memeId}`
      Rails.ajax({
        type: "POST",
        url: "/remove-upvote",
        data: mydata
      });
      upvote.classList.remove("epic-win-voted");
      upvote.classList.add("epic-win");
      oneVoteAllowed();
      removeOne();
    };
  });
};

if (downvote) {
  downvote.addEventListener("click", (event) => {
    if (downvote.classList.contains("epic-fail")) {
      const memeId = meme.id;
      console.log("adding downvote");
    	mydata = `meme[id]=${memeId}`
      Rails.ajax({
        type: "POST",
        url: "/downvote",
        data: mydata
      });
      downvote.classList.remove("epic-fail");
      downvote.classList.add("epic-fail-voted");
      oneVoteAllowed();
      removeOne();
    } else if (downvote.classList.contains("epic-fail-voted")) {
      const memeId = meme.id;
      console.log("removing downvote");
      mydata = `meme[id]=${memeId}`
      Rails.ajax({
        type: "POST",
        url: "/remove-downvote",
        data: mydata
      });
      downvote.classList.remove("epic-fail-voted");
      downvote.classList.add("epic-fail");
      oneVoteAllowed();
      addOne();
    }
  });
};


function oneVoteAllowed() {
  if (upvote.classList.contains("epic-win-voted")
      && downvote.classList.contains("epic-fail")) {
    downvote.classList.remove("epic-fail");
    downvote.classList.add("epic-fail-disabled");
  };
  if (upvote.classList.contains("epic-win")
      && downvote.classList.contains("epic-fail-disabled")) {
    downvote.classList.add("epic-fail");
    downvote.classList.remove("epic-fail-disabled");
  };
  if (downvote.classList.contains("epic-fail-voted")
      && upvote.classList.contains("epic-win")) {
    upvote.classList.remove("epic-win");
    upvote.classList.add("epic-win-disabled");
  };
  if (downvote.classList.contains("epic-fail")
      && upvote.classList.contains("epic-win-disabled")) {
    upvote.classList.add("epic-win");
    upvote.classList.remove("epic-win-disabled");
  }
};

function addOne () {
  let newNumber = parseInt(voteNumber.innerText, 10) + 1;
  voteNumber.innerText = newNumber;
}

function removeOne () {
  let newNumber = parseInt(voteNumber.innerText, 10) - 1;
  voteNumber.innerText = newNumber;
}

if (meme) {
  oneVoteAllowed();
};
