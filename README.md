## NeighboringWorlds

### Description
This program allows you to join a community of your neighbors, attend and organize community sponsored events, and share your experiences.

### How To Use This Program

In a web browser, navigate to http://52.8.112.153:8080/NeighboringWorlds

Click "Explore", then "Register" to create an account. You will be logged in
automatically upon account creation.

Browse Events using the "Events" link in the navigation menu. A search bar is
available to filter by keyword in titles and descriptions. You can also create an
event from this page, or select a single event to view its details and sign up
to attend.

Click "Profile" to access your profile page: edit your profile, see your upcoming
events, hosted events, and comment on the same.

Click "About" to learn more about the creators of NeighboringWorlds!



Routes:
| Return Type | Request Type | Route | Functionality  |
|-----------------|------------------------|-----------------------------------|
|List<CultureEvent>|	GET|	http://localhost:8090/api/culture-events	|READ Operation to show list of all Culture Events.|
|Culture Event|	GET	|http://localhost:8090/api/culture-events/{cid}	|READ Operation to show an individual Culture Event by its Id.|
|Culture Event|	POST|	http://localhost:8090/api/culture-events/	|CREATE Operation to add a new Culture Event. |
|Culture Event|	PUT	|http://localhost:8090/api/culture-events/{cid}|	UPDATE Operation to modify an existing Culture Event by its Id.|
|Boolean	|DELETE|	http://localhost:8090/api/culture-events/{cid}|	DELETE Operation to remove an existing Culture Event by its Id.|
List<UserComment>|	GET|	http://localhost:8090/api/comments/all	|READ - show list of all comments based on authorized username. Authorized user can view list of their own comments.|
|User Comment	|GET|	http://localhost:8090/api/comments/{ucid}	|READ - show individual comment by its comment Id.|
|List<User Comment>|	POST|	http://localhost:8090/api/culture-events/{cuid}/comments|	CREATE - a comment to Culture Event based on the Id of Culture Event.|
User Comment|	POST|	http://localhost:8090/api/comments/{ucid}/reply|CREATE - a reply on an existing comment.|
User Comment|	PUT|	http://localhost:8090/api/comments/{ucid}|	UPDATE - modify an existing comment that you own based on username.|
Boolean	|DELETE	|http://localhost:8090/api/comments/{ucid}|	DELETE - remove a comment that you own, based on username.|
List<User Comment>|	GET|	http://localhost:8090/api/culture-events/{cuid}/comments|	READ - show list of all comments of an individual culture event based on the culture event Id.|
List<Media>|	GET	|http://localhost:8090/api/media/all |	READ - show list of all media (with id, url, and caption) based on owner / username.|
List<Media>	|GET|	http://localhost:8090/api/culture-events/media |	READ - find all media based on Culture Event Id (by traversing through User Comment). Anyone can view this list. It's not locked down based on username, but they still have to be authorized. |
Media	|POST|	http://localhost:8090/api/comments/{cid}/media |	CREATE - add a media object onto an existing comment by comment Id.|
List<Event Tag>	|GET|	http://localhost:8090/api/tags/{keyword} |	READ - find a list of tags based on keyword search.|
List<Event Tag>	GET	http://localhost:8090/api/tags	READ - find a list of all tags.
Event Tag	| POST |	http://localhost:8090/api/tags |	CREATE - a new event tag keyword.|


### Technologies Used
* SQL
* Java
* REST
* JPA
* Spring
* Gradle
* JavaScript
* AJAX
* Angular
* Pipes
* Bootstrap

### Lessons Learned
