using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Net.Mail;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using SharedLibrary.SmtpClient;
using UsersDb.Trial;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(SubscriptionRequestMetadata))]
    public partial class SubscriptionRequest : IEntity, IAuditable
    {
        public override string ToString()
        {
            var methods = User?.SubscriptionRequests
                    .Where(r => r.Id == Id && !r.IsFulfilled)
                    .Select(m => m.MethodGroups.Where(g => !g.IsDeleted).ToString())
                    .ToList();

            return methods == null || methods.Count == 0
                ? string.Empty
                : string.Format(ServiceConfig.SubscriptionRequest_ToString_Template, Id, string.Join(ServiceConfig.New_Line, methods));
        }

        public void BeforeSave(UsersDataContext context, ObjectStateEntry entry)
        {
            if (entry.State == EntityState.Deleted) return;

            var request = entry.Entity as SubscriptionRequest;
            if (request != null)
            {
                if (request.Accepted)
                {
                    request.AcceptedBy = context.CurrentUserId;

                    switch (request.SubscriptionRequestType.Id)
                    {
                        case (int)SubscriptionRequestTypes.Add:
                            foreach (var methodGroup in request.MethodGroups)
                            {
                                var subscription = new Subscription
                                {
                                    UserId = request.UserId,
                                    MethodGroupId = methodGroup.Id
                                };

                                context.Subscriptions.AddObject(subscription);
                            }

                            break;

                        case (int)SubscriptionRequestTypes.Trial:
                            foreach (var methodGroup in request.MethodGroups)
                            {
                                var subscription = new Subscription
                                {
                                    UserId = request.UserId,
                                    MethodGroupId = methodGroup.Id
                                };

                                context.Subscriptions.AddObject(subscription);
                            }

                            break;

                        default:
                            foreach (var methodGroup in request.MethodGroups)
                            {
                                context.GetUser(request.UserId).Subscriptions
                                    .Where(s => s.MethodGroupId == methodGroup.Id)
                                    .ToList()
                                    .ForEach(g => context.Subscriptions.DeleteObject(g));
                            }

                            break;
                    }
                }

                if (request.IsFulfilled && request.Notify == true)
                {
                    var ts = new TrialSubscription(request.User.FullName, request.User.Email, request.User.Company.Name, request.User.Company.Phone);

                    if (request.Accepted)
                    {
                        ts.SendTrialAcceptanceEmail(context, request);
                    }
                    else
                    {
                        ts.SendTrialRejectionEmail(context, request);
                    }
                }
            }
        }

        public void AfterSave(UsersDataContext context, IEnumerable<ObjectStateEntry> entries)
        {
        }
    }

    [DisplayName("Subscription Requests")]
    [RestrictAction(Action = PageTemplate.Insert)]
    [TableCategory("Subscriptions")]
    public class SubscriptionRequestMetadata
    {
        [ScaffoldColumn(true)]
        public object Id { get; set; }

        [ReadOnly(true)]
        public object User { get; set; }

        [OrderBy("DESC")]
        [DisplayName("Request last update")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit)]
        public object LastUpdate { get; set; }

        [DisplayName("Email Sent")]
        [ReadOnly(true)]
        public object EmailSent { get; set; }

        [DisplayName("Is Fulfilled")]
        public object IsFulfilled { get; set; }

        [DisplayName("Accepted By")]
        [ReadOnly(true)]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object Acceptor { get; set; }

        [ScaffoldColumn(false)]
        public object AcceptedBy { get; set; }

        [ScaffoldColumn(false)]
        public object Trials { get; set; }

        [DisplayName("Request Type")]
        [ReadOnly(true)]
        public object SubscriptionRequestType { get; set; }


        [DisplayName("Requested Packages")]
        [UIHint("RequestMethodsField")]
        [ReadOnly(true)]
        public object MethodGroups { get; set; }
    }
}
