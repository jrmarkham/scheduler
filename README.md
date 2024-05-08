# Scheduler

#Design
I am particular about the DDD design pattern. It makes sense to me for Flutter development. Where the data is at the top of the hierarchy and the UI is mostly composed of Stateless widgets. For state management I used Blocs (Cubits specifically); this fits well into DDD architecture and Cubits are very light.

#Data
For data I wanted to use something real without using much time, so I used SharedPreferences which saves data on the device. This didn't take much longer than using mock data.

I created models for Providers, Clients, and Timeslots. I created models with the idea of expanding the code for a real app. Each model would have more properties in a real a pp so the groundwork is there. I set up the app to use only one client and one provider, but it is designed to handle more.

#UI
I created navigation for multiple screens again with the idea that the app could expand for functionality. I set up a basic theme for an app (again for expansion). I did very little to make it pretty as that is the last step, but the placeholders for designs are in place.

#Missing elements
* As mentioned previously there is a single Provider and a single Client.
* I didn't create a confirmation screen, but this would be easily accomplished with a new screen and a timer.

#What I would do next (in order)
* Add tests (unit and widget)
* Expand the app to use multiple Providers and clients
* Add the confirmation functionality
* Add sorts and filters to the schedule
* Make the app pretty or (prettier)