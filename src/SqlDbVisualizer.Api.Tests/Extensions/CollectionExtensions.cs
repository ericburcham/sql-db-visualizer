namespace SqlDbVisualizer.Api.Tests.Extensions;

internal static class CollectionExtensions
{
    public static void AddRange<T>(this ICollection<T> target, IEnumerable<T> source)
    {
        foreach (var o in source)
        {
            target.Add(o);
        }
    }
}