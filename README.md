# README

This README would normally document whatever steps are necessary to get the
application up and running.

(prerequisite– must have docker installed locally -  https://docs.docker.com/get-docker/ 

1.	Download docker image from: docker pull amitdoshi22/splunk-assignment:latest  (https://hub.docker.com/r/amitdoshi22/splunk-assignment/tags?page=1&ordering=last_updated)
2.	Run command docker-compose up
3.	URL - http://0.0.0.0:8000/api/homeassignment?type=pdf 
      a.	This URL supports 
            i.	count –(optional) default 10,  max 1000 (seems like there is offset limitation on the splunk api if it goes beyond 1000 offset) 
            ii.	query – (optional) if not provided default value is APM (As mentioned in the assignment) but you can try changing the query to expect different results
            iii.	type – (required) supported pdf and html only. (If other types are given then no results will be returned) 
      b.	example 
            i.	http://0.0.0.0:8000/api/homeassignment?type=html&count=10
            ii.	http://0.0.0.0:8000/api/homeassignment?type=pdf&count=10 
            iii.	With custom query param - http://0.0.0.0:8000/api/homeassignment?type=pdf&count=10&query=human 
      ![image](https://user-images.githubusercontent.com/6727513/130303006-bf47d2e4-6694-42ca-ad60-64f1882f9c0f.png)


Build the new project
docker-compose run --no-deps web rails new .
docker-compose build .

create new image
docker build . -t amitdoshi22/splunk-assignment:latest
push new image
docker push amitdoshi22/splunk-assignment:latest


Things you may want to cover:

* Ruby version
2.6.3

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
docker-compose build
  
docker-compose run

* ...
