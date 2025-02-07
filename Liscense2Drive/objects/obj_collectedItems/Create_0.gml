canDisplay = false;
collectedItemName = "";
collectedItemNum = 0;

Subscribe("Item Collected", function(_collectedItems) {
    self.collectedItemName = _collectedItems[$ "itemName"];
    self.collectedItemNum = _collectedItems[$ "itemCount"];
    canDisplay = true;
    counter = 0;
});

counter = 0;
timeToDisplay = 2;

textToDisplay = "";
image_alpha = 0;