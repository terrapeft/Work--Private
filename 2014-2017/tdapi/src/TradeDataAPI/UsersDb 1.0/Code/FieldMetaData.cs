using UsersDb.Code;

namespace UsersDb.Helpers
{
	using System.Collections.Generic;
	using System.Data;

	/// <summary>
	/// Class provides the structure to keep metadata for stored procedure input parameters or output columns.
	/// </summary>
	public class FieldMetaData
	{
		private readonly List<string> fixedSizeTypes = new List<string>
		{
			"bigint",
			"bit",
			"date",
			"datetime",
			"float",
			"geography",
			"geometry",
			"hierarchyid",
			"image",
			"int",
			"money",
			"ntext",
			"real",
			"smalldatetime",
			"smallint",
			"smallmoney",
			"sql_variant",
			"text",
			"timestamp",
			"tinyint",
			"uniqueidentifier",
			"xml"
		};

		private readonly List<string> precisionTypes = new List<string>
		{
			"decimal",
			"numeric",
		};

		/// <summary>
		/// Gets or sets the name of the table.
		/// </summary>
		/// <value>
		/// The name of the table.
		/// </value>
		public string TableName { get; set; }

		/// <summary>
		/// Field name.
		/// </summary>
		/// <value>
		/// The name.
		/// </value>
		public string Name { get; set; }

		/// <summary>
		/// Parsed name without "@param" prefix.
		/// </summary>
		/// <value>
		/// The method argument.
		/// </value>
		public string MethodArgument
		{
			get
			{
                return Name.Replace(WorkingDatabase.Instance.GetStoredProcParamPrefix(), string.Empty);
			}
		}

		/// <summary>
		/// Field size.
		/// </summary>
		/// <value>
		/// The size.
		/// </value>
		public int Size { get; set; }
		public int Precision { get; set; }
		public int Scale { get; set; }
		public string Type { get; set; }
		public bool IsNullable { get; set; }
		public ParameterDirection Direction { get; set; }


		/// <summary>
		/// Returns a <see cref="System.String" /> that represents this instance.
		/// </summary>
		/// <returns>
		/// A <see cref="System.String" /> that represents this instance.
		/// </returns>
		public override string ToString()
		{
			var size = string.Empty;

			if (Precision != 0 && Precision != 255 && Scale != 255 && this.TypeHasPrecisionAndScale(Type))
			{
				size = string.Format("({0},{1})", Precision, Scale);
			}
			else if (!this.IsFixedSizeType(Type))
			{
				if (Size > 0)
				{
					size = string.Format("({0})", Size);
				}
				else if (Size == -1)
				{
					size = "(max)";
				}
			}

			var isNull = IsNullable ? ", null" : ", not null";
			return string.Format("{0} ({1}{2}{3})", string.IsNullOrWhiteSpace(MethodArgument) ? "\"\"" : MethodArgument, Type, size, isNull);
		}

		/// <summary>
		/// Determines whether we need to specify the field size.
		/// </summary>
		/// <param name="typeName">Name of the type.</param>
		/// <returns></returns>
		private bool IsFixedSizeType(string typeName)
		{
			return fixedSizeTypes.Contains(typeName.ToLower());
		}

		/// <summary>
		/// Check type to learn if it has precision and/or scale.
		/// </summary>
		/// <param name="typeName">Name of the type.</param>
		/// <returns></returns>
		private bool TypeHasPrecisionAndScale(string typeName)
		{
			return precisionTypes.Contains(typeName.ToLower());
		}
	}
}
