
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, status) {
  response.success("Hello world!");
});

Parse.Cloud.define("getConversations", function(request, status) {
  var query = new Parse.Query("Message");
  var arrMessages = [];
  query.each(function(message) {
      // Update to plan value passed in
      /*user.set("plan", request.params.plan);
      if (counter % 100 === 0) {
        // Set the  job's progress status
        status.message(counter + " users processed.");
      }
      counter += 1;*/

      //allow editing data
      //Parse.Cloud.useMasterKey();

      var receivers = message.get('userReceiverName');
      var count = receivers.length;
      for(var i = 0; i<count; i++){
        if(receivers[i] === request.params.username){
            arrMessages.push(receivers[i]);
        }
      }

      /*if(message.get('userSenderName') === request.params.username){
        arrMessages.push(message);
      }*/
  }).then(function() {
    status.success(arrMessages);
  }, function(error) {
    status.error("Uh oh, something went wrong.");
  });
});
