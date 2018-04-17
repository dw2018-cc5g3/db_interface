#db_interface

DB interface. Flask code shouldn't know anything else about the database other
than the functions exposed in this module. (In case we suddenly move over to
Postgres or sqlite or something)

## Functions

### `create_item(score, mass, category, deposited_by, created_at=None, extra_info=None)`

Create a new deposited item.

- param created_at: Datetime of creation (if not specified just defaults to
server time)
- param score: Score int
- param mass: Mass int
- param category: Category int
- param deposited_by: User ID of depositing user
- param extra_info: Extra info in JSON format

return: Id of new item or False if create failed

### `create_user(can, name, display_name, phone_number, active=True)`

Create a new user.
    
- param can: CAN (compulsory)
- param name: Username (not compulsory)
- param display_name: Friendly name for display on UI (compulsory)
- param phone_number: Phone number for push notifs (not compulsory)
- param active: Is active (defaults to True)

return: Id of new user or False if couldn't create

### `get_leaderboard(limit=10)`

Get the leaderboard. Returns first 10 rows only!

`champion = get_leaderboard()[0]['display_name']` -> top user
    
return: a list of Record types

### `get_user_by_can(can_dirty)`

Get a user by card number
    
- param can_dirty: str

return: {user info} or None

### `get_user_items(user_id)`

Get a user's deposited items, most recent first
    
- param user_id: the user's id

return: a list of Record types

### `transform_can_to_canonical(can_dirty)`

Transform a CAN to the database format (string of digits).
    
- param can_dirty: Any CAN

return: Canonical DB-formatted CAN.
