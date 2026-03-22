using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace GROUP6_ANGAT {
    public static class DisplayHelper {

        // ── Tags & Badges ──
        public static string GetTagsHtml(object tagsObj, object categoryObj = null) {
            string tagsRaw = tagsObj == null ? string.Empty : tagsObj.ToString();
            if (string.IsNullOrWhiteSpace(tagsRaw)) return string.Empty;

            string[] tags = tagsRaw.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            var sb = new StringBuilder();

            foreach (string tag in tags) {
                string t = tag.Trim();
                if (string.IsNullOrEmpty(t)) continue;
                string css = GetTagCss(t, categoryObj?.ToString());
                sb.AppendFormat("<span class=\"badge {0}\">{1}</span> ", css, HttpUtility.HtmlEncode(t));
            }
            return sb.ToString();
        }

        public static string GetTagCss(string tag, string category = null) {
            string t = (tag ?? "").ToLowerInvariant();
            string cat = (category ?? "").ToLowerInvariant();

            // ── URGENCY ──
            if (t.Contains("urgent")) return "tag-rose";

            // ── EMPLOYMENT TYPE ──
            if (t.Contains("full-time")) return "tag-fulltime";
            if (t.Contains("part-time")) return "tag-parttime";

            // ── SCHEDULE — all blue ──
            if (t.Contains("weekday") || t.Contains("weekdays") ||
                t.Contains("weekend") || t.Contains("weekends") ||
                t.Contains("flexible")) return "tag-blue";

            // ── REQUIREMENTS — all amber ──
            if (t.Contains("experienced") || t.Contains("may karanasan") ||
                t.Contains("licensed") || t.Contains("pisikal") ||
                t.Contains("driver's license") || t.Contains("nbi") ||
                t.Contains("with tools")) return "tag-amber";

            // ── SERVICE TYPE — all teal ──
            if (t.Contains("repair") || t.Contains("install") ||
                t.Contains("wiring") || t.Contains("cleaning") ||
                t.Contains("maintenance") || t.Contains("gawa sa order") ||
                t.Contains("custom")) return "tag-teal";
            if (t.Contains("emergency")) return "tag-rose";

            // ── NEGOSYO PAYMENT — teal ──
            if (t.Contains("gcash")) return "tag-teal";

            // ── NEGOSYO ORDER — blue ──
            if (t.Contains("pick-up") || t.Contains("takeout") ||
                t.Contains("delivery") || t.Contains("dine-in")) return "tag-blue";

            // ── CATEGORY-BASED FALLBACK ──
            if (cat.Contains("karpintero")) return "tag-amber";
            if (cat.Contains("tubero")) return "tag-blue";
            if (cat.Contains("electric")) return "tag-teal";
            if (cat.Contains("aircon") || cat.Contains("appliance")) return "tag-mint";
            if (cat.Contains("mananahi")) return "tag-rose";
            if (cat.Contains("kasambahay") || cat.Contains("labandera")) return "tag-violet";
            if (cat.Contains("driver")) return "tag-blue";
            if (cat.Contains("carinderia") || cat.Contains("sari-sari")) return "tag-amber";

            return "tag-teal";
        }

        public static string GetStatusClass(object statusObj) {
            string status = (statusObj ?? "").ToString().ToLowerInvariant();
            if (status.Contains("filled") || status.Contains("busy")) return "badge-rose";
            if (status.Contains("paused")) return "badge-amber";
            if (status.Contains("available") || status.Contains("bukas")) return "badge-green";
            return "badge-teal";
        }

        // ── Pay & Rates ──
        public static string GetPayDisplay(object minObj, object maxObj, object rateObj) {
            if (minObj == DBNull.Value || minObj == null) return string.Empty;

            string rate = (rateObj ?? "").ToString()
                .Replace("per month", "buwan")
                .Replace("per day", "araw")
                .Replace("per hour", "oras")
                .Replace("per job", "bawat trabaho")
                .Replace("per unit", "unit");

            decimal min = Convert.ToDecimal(minObj);
            decimal max = maxObj == DBNull.Value || maxObj == null ? min : Convert.ToDecimal(maxObj);

            string formatted = min == max ? $"₱{min:N0}" : $"₱{min:N0}–₱{max:N0}";
            return $"{formatted} / {rate}";
        }

        // ── Dates & Sorting ──
        public static string GetDateLabel(object postedObj) {
            if (postedObj == null || postedObj == DBNull.Value) return string.Empty;
            if (!DateTime.TryParse(postedObj.ToString(), out DateTime posted)) return string.Empty;

            var diff = DateTime.UtcNow - posted;

            if (diff.TotalMinutes < 60) return "Kaninang umaga";
            if (diff.TotalHours < 24) return "Ngayong Araw";
            if (diff.TotalDays < 2) return "Kahapon";
            if (diff.TotalDays < 7) return $"{(int)diff.TotalDays} araw na ang nakalipas";
            if (diff.TotalDays < 14) return "Isang linggo na ang nakalipas";
            return $"{(int)(diff.TotalDays / 7)} linggo na ang nakalipas";
        }

        public static string GetPostedValue(object postedObj) {
            if (postedObj == null || postedObj == DBNull.Value) return "0";
            return DateTime.TryParse(postedObj.ToString(), out DateTime posted)
                ? posted.ToFileTimeUtc().ToString()
                : "0";
        }

        // ── Search & Meta ──
        public static string GetSearchText(object title, object tags, object barangay, object category, object location = null) {
            string t = (title ?? "").ToString();
            string tg = (tags ?? "").ToString().Replace("|", " ");
            string br = (barangay ?? "").ToString();
            string cat = (category ?? "").ToString();
            string loc = (location ?? "").ToString();

            return $"{t} {tg} {br} {cat} {loc}".Trim();
        }
    }
}