function Component(_idName) constructor {
    idName = _idName;    
}

function Components(_owner) constructor {
    owner = _owner;
    
    function GetComponent(componentName) 
    {
        if (self[$ componentName] != undefined) return self[$ componentName];
        else return undefined;
    }

    function AddComponent(component) {
        if (component == undefined or component[$ "idName"] == undefined) return false;

        if (self[$ component.idName] == undefined) self[$ component.idName] = component;
        else self[$ component.idName] = component;
    }

    function AddNonComponent(componentName, component) {
        if (self[$ componentName] == undefined) self[$ componentName] = component;
        else self[$ componentName] = component;
    }
}