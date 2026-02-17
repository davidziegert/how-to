function formatNumber(number) {
  if (number >= 10) {
    return number;
  } else {
    return "0" + number;
  }
}

function countdownTimer() {
  // display the actual timer
  let dayDisplay = document.getElementById("days");
  let hoursDisplay = document.getElementById("hours");
  let minutesDisplay = document.getElementById("minutes");
  let secondsDisplay = document.getElementById("seconds");

  // what day it will end
  const goaltime = new Date("12/31/2026").getTime();

  // in milliseconds
  const second = 1000;
  const minute = second * 60;
  const hour = minute * 60;
  const day = hour * 24;

  const intervalTimer = setInterval(() => {
    // what time is now?
    let actualtime = new Date().getTime();
    let difference = goaltime - actualtime;

    dayDisplay.innerText = formatNumber(Math.floor(difference / day));
    hoursDisplay.innerText = formatNumber(Math.floor((difference % day) / hour));
    minutesDisplay.innerText = formatNumber(Math.floor((difference % hour) / minute));
    secondsDisplay.innerText = formatNumber(Math.floor((difference % minute) / second));
  }, 1000);
}

countdownTimer();
