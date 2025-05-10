depth = -1000
currentStruct = undefined;
currentLine = 0;
text = "";
lineMapArray = [];
Subscribe("StartingInterpreter", function(_compiledStruct) {
    if (_compiledStruct[$ "RawCode"] == undefined) return;
    
    currentStruct = _compiledStruct;
    currentLine = 0;
    lineMapArray = [];
    text = ScribbleHighlightSyntax(currentStruct.RawCode);
    
    lineMapArray = string_split(text, "\n");
})

Subscribe("StoppingInterpreter", function(_compiledStruct) {
    currentStruct = undefined;
    
})

Subscribe("ExecutingInstruction", function(_lineNumber) {
    currentLine = _lineNumber - 1;
});