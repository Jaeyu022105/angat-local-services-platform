using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace GROUP6_ANGAT
{
    public static class DisplayHelper
    {
        // ── Tags & Badges ──
        public static string GetTagsHtml(object tagsObj, object categoryObj = null)
        {
            string tagsRaw = tagsObj == null ? string.Empty : tagsObj.ToString();
            if (string.IsNullOrWhiteSpace(tagsRaw)) return string.Empty;

            string[] tags = tagsRaw.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            var sb = new StringBuilder();

            foreach (string tag in tags)
            {
                string t = tag.Trim();
                if (string.IsNullOrEmpty(t)) continue;  

                string css = GetTagCss(t, categoryObj?.ToString());
                sb.AppendFormat("<span class=\"badge {0}\">{1}</span> ", css, HttpUtility.HtmlEncode(t));
            }
            return sb.ToString();
        }

        public static string GetTagCss(string tag, string category = null)
        {
            string t = (tag ?? "").ToLowerInvariant();
            string cat = (category ?? "").ToLowerInvariant();

            // Priority tags
            if (t.Contains("urgent")) return "tag-rose";
            if (t.Contains("full-time")) return "tag-fulltime";
            if (t.Contains("part-time")) return "tag-parttime";
            if (t.Contains("pisikal")) return "tag-physical";
            if (t.Contains("may karanasan")) return "tag-experience";
            if (t.Contains("live-in")) return "tag-housing";
            if (t.Contains("repair")) return "tag-blue";
            if (t.Contains("install") || t.Contains("wiring")) return "tag-teal";

            // Category-based fallback
            if (cat.Contains("karpintero")) return "tag-amber";
            if (cat.Contains("tubero")) return "tag-blue";
            if (cat.Contains("electric")) return "tag-teal";
            if (cat.Contains("aircon") || cat.Contains("appliance")) return "tag-mint";
            if (cat.Contains("mananahi")) return "tag-rose";

            // General fallbacks
            if (t.Contains("flexible")) return "tag-teal";
            if (t.Contains("weekdays")) return "tag-blue";
            if (t.Contains("weekends")) return "tag-violet";

            return "tag-teal";
        }

        public static string GetStatusClass(object statusObj)
        {
            string status = (statusObj ?? "").ToString().ToLowerInvariant();
            if (status.Contains("filled") || status.Contains("busy")) return "badge-rose";
            if (status.Contains("paused")) return "badge-amber";
            if (status.Contains("available") || status.Contains("bukas")) return "badge-green";
            return "badge-teal";
        }

        // ── Pay & Rates ──
        public static string GetPayDisplay(object minObj, object maxObj, object rateObj)
        {
            if (minObj == DBNull.Value || minObj == null) return string.Empty;

            string rate = (rateObj ?? "").ToString()
                .Replace("per month", "buwan")
                .Replace("per day", "araw")
                .Replace("per hour", "oras")
                .Replace("per job", "bawat trabaho");

            decimal min = Convert.ToDecimal(minObj);
            decimal max = maxObj == DBNull.Value || maxObj == null ? min : Convert.ToDecimal(maxObj);

            string formatted = min == max ? $"₱{min:N0}" : $"₱{min:N0}–₱{max:N0}";
            return $"{formatted} / {rate}";
        }

        public static string GetServicePayDisplay(object rateObj)
        {
            string rate = (rateObj ?? "").ToString();
            if (string.IsNullOrWhiteSpace(rate)) return string.Empty;

            // Handle encoding issues
            rate = rate.Replace("?", "₱").Replace("\u00E2\u201A\u00B1", "₱").Replace("\u20B1", "₱");

            if (!rate.Contains("₱") && !rate.StartsWith("PHP", StringComparison.OrdinalIgnoreCase))
            {
                rate = "₱" + rate.TrimStart();
            }

            return HttpUtility.HtmlEncode(rate);
        }

        public static string GetRateSortValue(object rateObj)
        {
            string rate = (rateObj ?? "").ToString();
            if (string.IsNullOrWhiteSpace(rate)) return "0";

            string cleaned = "";
            foreach (char c in rate)
            {
                if (char.IsDigit(c) || c == '.') cleaned += c;
            }
            
            return decimal.TryParse(cleaned, out decimal val) ? val.ToString() : "0";
        }

        // ── Dates & Sorting ──
        public static string GetDateLabel(object postedObj)
        {
            if (postedObj == null || postedObj == DBNull.Value) return string.Empty;
            if (!DateTime.TryParse(postedObj.ToString(), out DateTime posted)) return string.Empty;

            var now = DateTime.Now.AddHours(-8);
            var diff = now - posted;

            if (diff.TotalHours < 24)
            {
                int hour = posted.Hour;
                if (hour < 24) return "Ngayong Araw";
            }
            if (diff.TotalDays < 2) return "Kahapon";
            if (diff.TotalDays < 7) return $"{(int)diff.TotalDays} araw na ang nakalipas";
            if (diff.TotalDays < 14) return "Isang linggo na ang nakalipas";
            return $"{(int)(diff.TotalDays / 7)} linggo na ang nakalipas";
        }

        public static string GetPostedValue(object postedObj)
        {
            if (postedObj == null || postedObj == DBNull.Value) return "0";
            return DateTime.TryParse(postedObj.ToString(), out DateTime posted) 
                ? posted.ToFileTimeUtc().ToString() 
                : "0";
        }

        // ── Search & Meta ──
        public static string GetSearchText(object title, object tags, object barangay, object category, object location = null)
        {
            string t = (title ?? "").ToString();
            string tg = (tags ?? "").ToString().Replace("|", " ");
            string br = (barangay ?? "").ToString();
            string cat = (category ?? "").ToString();
            string loc = (location ?? "").ToString();

            return $"{t} {tg} {br} {cat} {loc}".Trim();
        }
    }
}
