# Build Phase
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . . 

# What would be the difference between using RUN and CMD here?
RUN npm run build


# Run Phase - by adding another FROM statement, we automatically signal the first phase is complete
# Note: AWS might have issues with named builders
# See alternative synatax: https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/22538182#overview
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# we don't need a startup command b/c that is already the startup command of the nginx base image