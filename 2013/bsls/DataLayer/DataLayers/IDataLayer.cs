namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
    public interface IDataLayer
    {
        int ConnectionsCount { get; set; }
        bool IsConnected { get; }
        DataLayerConnection Connect();
        void Disconnect();
    }
}
