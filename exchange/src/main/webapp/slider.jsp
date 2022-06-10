let slideIndex = 0;
let timer1 = 0;

function changeSlideView(){

    let slides = document.getElementsByClassName("slides");

    if(slideIndex > slides.length-1){

        slideIndex = 0;

        for (let i = 0; i < slides.length; i++){

            slides[i].style.display = "none";

        }

        slides[slideIndex].style.display = "block";

        timer1 = setTimeout("changeSlideView()", 5000);

        slideIndex++;

    }

    else{

        for (let i = 0; i < slides.length; i++){

            slides[i].style.display = "none";

        }

        slides[slideIndex].style.display = "block";

        timer1 = setTimeout("changeSlideView()", 5000);

        slideIndex++;

    }

};
