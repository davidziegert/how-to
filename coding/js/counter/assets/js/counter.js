const counters = document.querySelectorAll(".follower-counter");

counters.forEach((counter) => {
  const incrementCounter = () => {
    // get target number
    const target = parseInt(counter.getAttribute("data-target"));
    // get current number
    const currentNumber = parseInt(counter.innerText);
    // set incrementer
    const increment = target / 300;

    if (currentNumber < target) {
      counter.innerText = `${Math.ceil(currentNumber + increment)}`;
      setTimeout(incrementCounter, 1);
    } else {
      counter.innerText = target;
    }
  };

  incrementCounter();
});
