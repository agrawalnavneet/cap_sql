using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using student.Models;
using  MVCwithADO.Models;


namespace student.Controllers;

public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

    public IActionResult Privacy()
    {
        return View();
    }
  

public IActionResult Studentdata(int m1, int m2, int m3) {
    int x = m1 + m2 + m3;
    return View(x);
}


    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
