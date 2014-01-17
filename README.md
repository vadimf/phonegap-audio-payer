phonegap-audio-payer
====================
Why?
====
Working on a phonegap radio application we noticed that when the application is running in background mode the songs are not alsways skipped with HTML5 radio player. 
Which is quite understandable - this is what you find in apple documentation: <blockquote>As long as it is playing audio or video content or recording audio content, the app continues to run in the background. However, if recording or playback stops, the system suspends the app.</blockquote>

CDVSound audio plugin introduced serious lags, so we decided to develop a simple plugin that solves three issues:
<ul>
<li>Playlists can be played in background</li>
<li>Song title, artist, etc is shown on iPhone lock screen</li>
<li>There are no lags (or they are minimal)</li>
</ul>

Feel free to fork and improve.

Installation
=============
Add the following frameworks to your project:
<ul>
<li>AVFoundation.framework</li>
<li>CoreAudio.framework</li>
<li>MediaPlayer.framework</li>
<li>AudioToolbox.framework</li>
</ul>

Add the following lines to your info.plist file:

	<key>UIBackgroundModes</key>
	<array>
		<string>audio</string>
	</array>

	
Add AudioPlayerPlugin.js to /www/js folder.
	
Add the following lines to your confix.xml file:
`  <feature name="AudioPlayerPlugin">
    <param name="ios-package" value="AudioPlayerPlugin" />
  </feature>`
  
Add the following files into your XCode project:

<ul>
<li>AudioPlayerPlugin.m</li>
<li>AudioPlayerPlugin.h</li>
<li>GBAudioPlayer.m</li>
<li>GBAudioPlayer.h</li>
</ul>

Usage
=====

Check index.html file for the code example.
