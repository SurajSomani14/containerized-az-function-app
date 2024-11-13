using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace POC
{
    public class ServiceBusTopicTrigger1
    {
        [FunctionName("ServiceBusTopicTrigger1")]
        public void Run([ServiceBusTrigger("mytopic", "mysubscription", Connection = "SB_Conn_String")]string mySbMsg, ILogger log)
        {
            log.LogInformation($"C# ServiceBus topic trigger function processed message: {mySbMsg}");
        }
    }
}
