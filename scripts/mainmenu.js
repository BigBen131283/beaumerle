let navigation = document.querySelector(".navigation");
let lastScrollValue = 0;

document.addEventListener('scroll', () => {
    let top = document.documentElement.scrollTop;
    if(lastScrollValue < top){
        navigation.classList.add("hidden");
    }
    else
    {
        navigation.classList.remove("hidden");
    }
    lastScrollValue = top;
})