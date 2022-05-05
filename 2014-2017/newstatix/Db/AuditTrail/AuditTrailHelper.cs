using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;
using Db.Json;
using Newtonsoft.Json;
using SharedLibrary;
using SharedLibrary.IPAddress;

namespace Db.AuditTrail
{
    /// <summary>
	/// Contains logic for changes tracking.
	/// </summary>
	public class AuditTrailHelper : IDisposable
	{
		private readonly StatixEntities dc;
	    private IEnumerable<string> modifiedProperties = null;

        public AuditTrailHelper(StatixEntities usersDataContext)
		{
			dc = usersDataContext;
		}

		/// <summary>
		/// Checks if any Audit instances require update and then commits changes.
		/// </summary>
		public void Dispose()
		{
			var audits = dc.Audits.ToList();
			var track =	audits
				.Where(a => a.TrackEntity != null)
				.ToList();

			if (track.Any())
			{
				foreach (var audit in track)
				{
					UpdateIdValue(audit);
				}

				dc.SaveChanges();
			}
		}

		/// <summary>
		/// Updates the id with generated value from database.
		/// </summary>
		/// <param name="audit">The audit.</param>
		private void UpdateIdValue(Audit audit)
		{
			var values = JsonConvert.DeserializeObject<IEnumerable<AuditParameterJson>>(audit.Values).ToList();
            
			var elem = values.FirstOrDefault(e => e.ParameterName == "Id");
		    if (elem != null)
		    {
		        elem.NewValue = audit.TrackEntity.Id.ToString();
		    }

            audit.Values = JsonConvert.SerializeObject(values);
			audit.TrackEntity = null;
		}

		/// <summary>
		/// Adds the specified entry to log.
		/// </summary>
		/// <param name="entry">The entry.</param>
		public void Add(ObjectStateEntry entry)
		{
            modifiedProperties = entry
                .GetModifiedProperties()
                .Where(p => entry.OriginalValues[p].ToStringOrEmpty() != entry.CurrentValues[p].ToStringOrEmpty());

		    if (modifiedProperties.Any() || entry.State == EntityState.Deleted || entry.State == EntityState.Added)
		    {
		        dc.Audits.AddObject(new Audit()
		        {
		            Id = Guid.NewGuid(),
		            RecordDate = DateTime.Now,
		            TableName = entry.EntitySet.Name,
		            UserId = dc.CurrentUserId,
                    IpAddr = IpAddressHelper.GetIPAddress(),
		            Values = GetAsJson(entry, entry.State),
		            ActionId = GetActionId(entry.State),
		            TrackEntity = (entry.State == EntityState.Added) ? (IAuditable) entry.Entity : null
		        });
		    }
		}

		/// <summary>
		/// Adds the specified Audit to log.
		/// </summary>
		/// <param name="au">The au.</param>
		public void Add(Audit au)
		{
			dc.Audits.AddObject(au);
		}

		/// <summary>
		/// Maps EntityState enum to AuditAction enum.
		/// </summary>
		/// <param name="state">The entity state.</param>
		/// <returns></returns>
		private int GetActionId(EntityState state)
		{
			return (int)(state == EntityState.Added ? AuditAction.Create : state == EntityState.Modified ? AuditAction.Update : AuditAction.Delete);
		}

        /// <summary>
        /// Gets changed values as JSON.
        /// </summary>
        /// <param name="entry">The entity's entry.</param>
        /// <param name="action">The action.</param>
        /// <returns></returns>
		private string GetAsJson(ObjectStateEntry entry, EntityState action)
		{
            var log = new List<AuditParameterJson>();

			if (action == EntityState.Deleted)
			{
				for (int k = 0; k < entry.OriginalValues.FieldCount; k++)
				{
					var name = entry.OriginalValues.GetName(k);
					var value = entry.OriginalValues.GetValue(k);

					if (value != null && !string.IsNullOrEmpty(value.ToString()))
					{
                        log.Add(new AuditParameterJson { ParameterName = name, OriginalValue = value.ToString()});
					}
				}
			}
			else if (action == EntityState.Added)
			{
				for (int k = 0; k < entry.CurrentValues.FieldCount; k++)
				{
					var name = entry.CurrentValues.GetName(k);
					var value = entry.CurrentValues.GetValue(k);
					if (value != null && !string.IsNullOrEmpty(value.ToString()))
					{
                        log.Add(new AuditParameterJson { ParameterName = name, NewValue = value.ToString() });
                    }
				}
			}
			else if (action == EntityState.Modified)
			{
				var auditable = (IAuditable)entry.Entity;
				if (auditable != null)
				{
                    log.Add(new AuditParameterJson { ParameterName = "Id", OriginalValue = auditable.Id.ToString() });
				}

				foreach (var prop in modifiedProperties)
				{
					var oValue = (entry.OriginalValues[prop] ?? string.Empty).ToString();
					var cValue = (entry.CurrentValues[prop] ?? string.Empty).ToString();
				    var e = new AuditParameterJson {ParameterName = prop, OriginalValue = oValue, NewValue = cValue};

					if (!string.IsNullOrEmpty(oValue) || !string.IsNullOrEmpty(cValue))
					{
                        log.Add(e);
                    }
				}
			}

			return JsonConvert.SerializeObject(log);
		}
	}
}
