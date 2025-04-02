// Handle time progression
if (state == "DAY_HOLD") {

    if (!doOncePerDay) {
        // Do something once per day
        daysSurvived += 1;
        Raise("DayDisplayOpen", id);
        Raise("Day", id);
        if (daysSurvived >= 3) {
            Transition(rmWin, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }

        doOncePerDay = true;
    }

    holdTimer += 1;
    if (holdTimer >= holdTime) {
        holdTimer = 0;
        state = "DAY_TO_NIGHT";
    }
}
else if (state == "DAY_TO_NIGHT") {
    timeOfDay -= transitionSpeed;
    if (timeOfDay <= 0) {
        timeOfDay = 0;
        holdTimer = 0;
        state = "NIGHT_HOLD";
    }
}
else if (state == "NIGHT_HOLD") {

    if (doOncePerDay) {
        Raise("Night", id);
        doOncePerDay = false;
    }

    holdTimer += 1;
    if (holdTimer >= holdTime) {
        holdTimer = 0;
        state = "NIGHT_TO_DAY";
    }
}
else if (state == "NIGHT_TO_DAY") {
    timeOfDay += transitionSpeed;
    if (timeOfDay >= 1) {
        timeOfDay = 1;
        holdTimer = 0;
        state = "DAY_HOLD";
    }
}

// Update alpha for visuals
alphaValue = 1 - timeOfDay;