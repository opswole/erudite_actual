# Erudite

## A note to Aston Staff
If you're reviewing this code-base please ensure it's the codebase at commit [f275acc](https://github.com/ChrisFDev00/erudite_actual/tree/f275acc364614bdbaaf58cee66defce4d0117e53) as this was the commit zipped & submitted to Blackboard. For convenience, the codebase at this point is available as a [release](https://github.com/ChrisFDev00/erudite_actual/releases/tag/Submitted) 
## Running Locally

`$ git clone https://github.com/ChrisFDev00/erudite_actual.git`

`$ cd erudite_actual`

`$ bundle install`

`$ npm install`

`$ bin/rails server` -> Starts the Rails Server

*open another terminal window*

`$ bundle exec vite dev` -> Starts Vite Dev


Doing the above will start Erudite but it will be unusable due to absence of any database information.

To seed the database accordingly you'll need to configure [ActiveStorage](https://guides.rubyonrails.org/active_storage_overview.html)
to use a BLOB storage. Erudite was built using an S3, though this will rapidly reach its free tier limit for GET requests.
