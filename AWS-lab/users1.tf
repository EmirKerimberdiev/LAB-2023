resource "postgresql_table" "users" {
  name = "users.tf"

  column {
    name = "username"
    type = "text"
  }

  column {
    name = "UID"
    type = "int"
  }

  column {
    name = "GID"
    type = "int"
  }

  column {
    name = "homedir"
    type = "text"
  }
}
