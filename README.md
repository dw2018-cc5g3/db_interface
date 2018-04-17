# db_interface

DB interface. Flask code shouldn't know anything else about the database other
than the functions exposed in this module. (In case we suddenly move over to
Postgres or sqlite or something)

## Sample data

Run the included `smartbin_sampledata.sql` to get a db with some testing data.

## Suggested API

    GET /user/<can> -> get_user_by_can()
    GET /item/by_user/<user_id> -> get_user_items()
    
    GET /leaderboard -> render with get_leaderboard()
    
    POST /user -> create_user()
    POST /item -> create_item()

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

The return data has this structure:
    
    [<Record {"id": 3, "name": "nikos", "display_name": "Nikos", "score_sum": "2039"}>,
     <Record {"id": 1, "name": "lionell", "display_name": "Lionell Loh", "score_sum": "1118"}>,
     <Record {"id": 2, "name": "andre", "display_name": "Andre HL", "score_sum": "890"}>,
     <Record {"id": 12, "name": "emir", "display_name": "Emir Hamzah", "score_sum": "579"}>,
     <Record {"id": 5, "name": "claire", "display_name": "Claire", "score_sum": "0"}>]

So the template code needs to use some kind of `{% for entry in leaderboard %}` block...

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
