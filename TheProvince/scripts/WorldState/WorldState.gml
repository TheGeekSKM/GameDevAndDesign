enum WeatherState {
    CLEAR,
    STORMY,
    DROUGHT
}

function WorldState() constructor {
    NobleAffinity = 5 // 0-10 scale 0 means they love you, 10 means they hate you
    FarmerAffinity = 5 // 0-10 scale 0 means they love you, 10 means they hate you
    CorruptionLevel = 2; // 0-10 scale 0 means no corruption, 10 means full corruption
    CurrentWeatherState = WeatherState.CLEAR;
    
    IsAtWar = false;
    IsEnemyPlanningAttack = false;
    IsSpyDiscovered = false;
    HasAlliance = false;

    Timeline = [];

    /// @desc AddTimelineEvent adds a new event to the timeline.
    /// @param {Real} _num - The number of the turn when the event occurred.
    /// @param {String} _eventName - The name of the event.
    /// @param {Boolean} _accepted - Whether the event was accepted or not.
    function AddTimelineEvent(_num, _eventName, _accepted) {
        var event = new TimelineData(_num, _eventName, _accepted);
        array_push(Timeline, event);
    }

    /// @desc GetTimelineEventByName returns the first event in the timeline with the given name.
    /// @param {String} _eventName - The name of the event to search for.
    /// @returns {TimelineData} - The first event with the given name, or undefined if not found.
    function GetTimelineEventByName(_eventName) {
        for (var i = 0; i < array_length(Timeline); i++) {
            if (Timeline[i].eventName == _eventName) {
                return Timeline[i];
            }
        }
        return undefined;
    }

    /// @desc GetTimelineEventByNum returns the first event in the timeline with the given number.
    /// @param {Real} _num - The number of the event to search for.
    /// @returns {TimelineData} - The first event with the given number, or undefined if not found.
    function GetTimelineEventByNum(_num) {
        for (var i = 0; i < array_length(Timeline); i++) {
            if (Timeline[i].num == _num) {
                return Timeline[i];
            }
        }
        return undefined;
    }

    /// @desc GetTimelineEvents returns the entire timeline array.
    /// @returns {Array} - The timeline array containing all events.
    function GetTimelineEvents() {
        return Timeline;
    }

}


/// @desc TimelineData is a structure that holds information about an event in the timeline.
/// @param {Real} _num - The number of the turn when the event occurred.
/// @param {String} _eventName - The name of the event.
/// @param {Boolean} _accepted - Whether the event was accepted or not.
/// @returns {TimelineData} - A new instance of TimelineData.
function TimelineData(_num, _eventName, _accepted) constructor 
{
    num = _num;
    eventName = _eventName;
    accepted = _accepted;
}