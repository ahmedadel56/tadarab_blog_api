# Rails Blog API Documentation

## Introduction

This Rails API application offers a robust blogging platform, featuring CRUD functionality for blog posts, user authentication, and management of categories and tags. It's designed with an admin dashboard in mind, providing detailed endpoints for blog administration.

## System Dependencies

- **Ruby**: `3.2.2`
- **Rails**: `7.1.2`
- **Database**: PostgreSQL
- **Key Gems**:
  - `Devise` for user authentication
  - `JWT` for token-based authentication
  - `Puma` as the web server
  - `Bullet` for N+1 problem
  - `CanCanCan` for authorization
  - Testing: `RSpec`, `FactoryBot`

## Setup Instructions

1. **Clone the Repository**: Obtain the code by cloning the Git repository.
2. **Install Dependencies**: Run `bundle install`.
3. **Database Setup**: Initialize with `rails db:create db:migrate db:seed`.
4. **Start the Server**: Launch with `rails server`.

## Features

- **CRUD Operations**: Manage blog posts with full create, read, update, and soft delete capabilities.
- **User Authentication**: Secure user authentication using JWT.
- **Role-Based Access Control**: Implemented with CanCanCan.
- **Categories & Tags**: Manageable blog categorization and tagging.
- **Validations**: Robust validations for blog fields, including image formats and sizes.

## API Endpoints

- **Blogs**: Endpoints for blog management.
- **Categories & Tags**: Endpoints for listing and managing categories and tags.
- **Users**: Comprehensive user management.
- **Authentication**: User login and logout.

## Swagger API Documentation

To view and interact with the API's live documentation, navigate to `/api-docs` after starting your server. This will open the Swagger UI, a dynamic interface for exploring and testing the API endpoints.

To access the Swagger UI:

1. Start the Rails server locally with `rails server`.
2. Open a web browser and go to `http://localhost:3000/api-docs`.
3. You can now interact with your API's endpoints directly through the Swagger interface.

## Testing

- **Test Suite**: Comprehensive tests with RSpec.
- **Swagger Documentation**: Detailed API documentation.
- **Factories**: Predefined factories for blogs, users, categories, tags, sections, and token blocklists.

## Database Schema

- Detailed tables for blogs, users, categories, tags, sections, and token blocklists.

## Authentication and Authorization

- **JWT**: Secure token-based user authentication.
- **Role-Based Permissions**: Managed with CanCanCan.

## Contributing

Contributions are welcome. Refer to `CONTRIBUTING.md` for guidelines.

## Versioning

Versioning follows [SemVer](http://semver.org/) standards.

## Authors

- **[Ahmed Adel]**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
