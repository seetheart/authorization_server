# About

For Making the system simple I have only created App, Role and Permission model where an App can have many Roles and Each permission 
is mapped to a single Role. There is a separate authentication service which will authenticate the request everytime. When a request
is received it to an App, Authservice will be called to check the permission fo a particular role. A call to Authorization server
is currently being made with an API_KEY header for simplicity but different access keys can be give to different applications.

Further Improvements
1) An application can be given ACCESS_KEY which will be used to identify from which application the request is coming.
2) App can have many-to-many relationship using has_many through using an intermediate table app_role_mappings which will
   contain a specific role in a specific application becuase multiple applications can have same roles.
3) A many-to-many relation can be made between app_role_mappings table permissions using has_and_belongs_to_many.
