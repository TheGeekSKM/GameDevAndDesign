// Inherit the parent event
event_inherited();

// Normalize inputs
var norm_quality = clamp(global.GameData.Quality, 0, 150) / 100; // e.g. 100 = 1.0, 120 = 1.2
var norm_interest = clamp(global.GameData.Interest, 0, 150) / 100;

// Step 1: Estimate potential reach based on Interest
var base_audience = norm_interest * 5000; // 0–7,500+ potential customers

// Step 2: Conversion rate depends on Quality
var conversion_rate = 0.2 + (norm_quality * 0.5); // 20% base, up to ~95% for 150 quality

// Step 3: Personal Satisfaction bonus (longevity & updates)
var satisfaction_bonus = 1 + ((global.GameData.PersonalSatisfactionModifier - 1) * 0.5); 
// So 1.75 becomes a 37.5% sales boost

// Step 4: Burnout penalty (launch & marketing weakness)
var burnout_penalty = 1 - min(global.GameData.Burnout, 10) * 0.04; 
// Max -40% sales at burnout = 10

// Step 5: Final estimated unit sales
var estimated_sales = base_audience * conversion_rate * satisfaction_bonus * burnout_penalty;
estimated_sales = round(max(0, estimated_sales));

var qualityText = "Terrible Quality [slant](You probably don't want people to see this game...)[/]";
var qualityNum = global.GameData.Quality / 100
if (qualityNum > 1.2) qualityText = "Beyond Excellent Quality [slant](Unbelievable Mechanics and Emmergent Gameplay)[/]";
else if (qualityNum > 1) qualityText = "Excellent Quality [slant](Really Fun Systems with Excellent Art)[/]";
else if (qualityNum > 0.75) qualityText = "Pretty Good Quality [slant](Solid Mechanics and Decent Art)[/]";
else if (qualityNum > 0.5) qualityText = "Good Quality [slant](Fun and Simple Mechanics with Simple Art)[/]";
else if (qualityNum > 0.25) qualityText = "Bad Quality [slant](Minimally Developed Mechanics and Confusing Art)[/]";

// put it into text
var gameDataText = "Game Data: \n\n";
gameDataText = string_concat(gameDataText, $"GameName: {global.GameData.Name}\n");
gameDataText = string_concat(gameDataText, $"Quality: {qualityText}\n");
gameDataText = string_concat(gameDataText, $"Interest: {global.GameData.Interest / 5} Wishlists\n");
gameDataText = string_concat(gameDataText, $"Estimated Sales: {estimated_sales}\n");
gameDataText = string_concat(gameDataText, $"Burnout: {global.GameData.Burnout}\n");
gameDataText = string_concat(gameDataText, $"Personal Satisfaction Modifier: {global.GameData.PersonalSatisfactionModifier}\n\n");

var finalProfitText = "Final Profit: $" + string(estimated_sales * 3) + "\n\n"; // Assuming $10 per unit

var finalText = string_concat(gameDataText, finalProfitText);

if (global.GameData.Burnout >= 7) {
    finalText = string_concat(finalText, "[c_grey]\"I don't think I can keep this up...I'm not sure I wanna code anymore...\"\n");
}
else if (global.GameData.Burnout >= 5) {
    finalText = string_concat(finalText, "[/]\"I probably could've taken some time off...\"\n");
} 
else if (global.GameData.Burnout >= 3) {
    finalText = string_concat(finalText, "[/]\"Thank god I took a break!\"\n");
}
else if (global.GameData.Burnout < 3) {
    finalText = string_concat(finalText, "[wave]\"This was super fun!!! I'd love to do this again!!\"\n");
}

text = finalText;
