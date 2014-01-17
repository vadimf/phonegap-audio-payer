var audioPlayerPlugin = {
    
    play: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "play", []);
    },
    
    pause: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "pause", []);
    },
        
        
    playURL: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "playURL", [urlString]);
    },
    addNextURL: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "addNextURL", [urlString]);
    },
    playNext: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "playNext", []);
    }
    
};