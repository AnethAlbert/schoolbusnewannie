// const redis = require('redis');
const Redis = require('ioredis');

// Create a Redis client instance using ioredis
const redisClient = new Redis({
  host: '127.0.0.1',
  port: 6379,
});

// const redisClient = new Redis({
//   host: "172.24.193.6",
//   port: 6379,
// });

// Redis client event handlers
redisClient.on('connect', () => {
  console.log('Client connected to Redis.');
});

redisClient.on('ready', () => {
  console.log('Client connected to Redis and ready to use.');
});

redisClient.on('error', err => {
  console.error('Redis client error:', err);
});

redisClient.on('end', () => {
  console.log('Client disconnected from Redis.');
});

module.exports = {
  redisClient,
};
