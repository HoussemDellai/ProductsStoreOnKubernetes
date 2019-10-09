using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using MvcApp.Models;
using Prometheus;

namespace MvcApp
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllersWithViews();
           
            services.AddDbContext<ProductsContext>(options =>
                    options.UseSqlServer(Configuration.GetConnectionString("ProductsContext")));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            // Export metrics to Prometheus
            // https://localhost:5001/metrics
            app.UseMetricServer(url: "/metrics");

            app.UseHttpMetrics(options =>
            {
                //options.RequestCount.Enabled = false;

                //options.RequestDuration.Histogram = Metrics.CreateHistogram("myapp_http_request_duration_seconds", "Some help text",
                //    new HistogramConfiguration
                //    {
                //        Buckets = Histogram.LinearBuckets(start: 1, width: 1, count: 64),
            
                //        LabelNames = new[] { "code", "method" }
                //    });
            });

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
