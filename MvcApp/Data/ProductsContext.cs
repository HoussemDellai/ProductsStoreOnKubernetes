using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace MvcApp.Models
{
    public class ProductsContext : DbContext
    {
        public ProductsContext (DbContextOptions<ProductsContext> options)
            : base(options)
        {
            Database.EnsureCreated();
        }

        public DbSet<MvcApp.Models.Product> Product { get; set; }
    }
}
