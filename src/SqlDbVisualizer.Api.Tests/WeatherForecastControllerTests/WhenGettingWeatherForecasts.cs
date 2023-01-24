using FluentAssertions;
using Microsoft.Extensions.Logging;
using NSubstitute;
using SqlDbVisualizer.Api.Controllers;
using SqlDbVisualizer.Api.Tests.Extensions;

namespace SqlDbVisualizer.Api.Tests.WeatherForecastControllerTests;

public class WhenGettingWeatherForecasts
{
    private IList<WeatherForecast> _results = new List<WeatherForecast>();

    [SetUp]
    public void Setup()
    {
        var logger = Substitute.For<ILogger<WeatherForecastController>>();
        var controller = new WeatherForecastController(logger);
        _results.AddRange(controller.Get());
    }

    [Test]
    public void ThereShouldBeAtLeastOneForecast()
    {
        _results.Should().HaveCountGreaterThan(0);
    }
}