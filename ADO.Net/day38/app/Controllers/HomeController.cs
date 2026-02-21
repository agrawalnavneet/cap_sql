using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using app.Models;

namespace app.Controllers;

public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

public IActionResult TestError()
{
    try
    {
        int x = 10;
        int y = 0;
        int result = x / y;
        return Content(result.ToString());
    }
    catch (Exception ex)
    {
        return Content("Error: " + ex.Message);
    }
}
    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    // public IActionResult Error()
    // {
    //     return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    // }

public ActionResult Error()
    {
        return View();

    }

public ActionResult Send()
    {
        TempData["Message"]="hello i am  good";
        return RedirectToAction("receive", "Student");
    }


}

