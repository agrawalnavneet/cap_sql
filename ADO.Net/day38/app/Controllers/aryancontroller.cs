using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using app.Models;

namespace app.Controllers;

public class aryancontroller: Controller
{

    public IActionResult Receive()
{
    var msg = TempData["Message"];
    return Content(msg?.ToString());
}
   
}