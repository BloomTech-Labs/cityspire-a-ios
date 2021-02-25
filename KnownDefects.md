## Known Defects or Known Improvements to be made

- Unfinished feature with adding Lottie Images (not all stats have Lottie Images)
- Possibly change search feature to not be a search controller but yet a floating search bar
- Missing autocomplete when typing in location on search bar (make sure to still include full state name not abbreviated)
- Consider cleaning up Emojis on the city data to make it more identifiable and clearer on what data it's representing
- Change the detail views to be one single view (currently two seperate views) in order to make the project more concise. 
- Simplify the network calls so that they are fewer in the app (Consider saving the returned city data locally so that it is not needed to be pulled everytime it is loaded.)
- Avatars from Okta aren't confirmed to be pulled into the app, check to see if you can get them loaded
- On TestUser001, the front end web team had some issues with the app adding in the country to the saved city. This is an issue for our application because the way the backend works it does NOT accept the country and therefore things added in on that user don't load properly in app. We would reccomend either working with front end to remedy this problem, or just simply use another test user account.
