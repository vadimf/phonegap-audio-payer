var audioPlayerPlugin = {
    
    play: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "play", []);
    },
    
    pause: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "pause", []);
    },
        
        
    playURL: function(urlString, songTitle, albumTitle, artistName, success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "playURL", [urlString, songTitle, albumTitle, artistName]);
    },
    addNextURL: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "addNextURL", [urlString]);
    },
    playNext: function(success, failure){
        cordova.exec(success, failure, "AudioPlayerPlugin", "playNext", []);
    }
    
};